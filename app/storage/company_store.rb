class CompanyStore
  include Cacheable
  include Elasticsearch::Searchable

  SEARCH_RESULTS_COUNT = 15

  def basic_search_from_es(search_text)
    query = BasicSearchMatcher.new(search_text).build_query
    companies = search(query: query, options: { size: SEARCH_RESULTS_COUNT })
    companies.map { |company| _domain.from_es_response(company) }
  end

  def by_symbol(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      _domain.from_db_entity(_full_companies.where(symbol: symbol).first)
    end
  end

  def by_symbols(symbols)
    _full_companies.where(symbol: symbols).map { |company| _domain.from_db_entity(company) }
  end

  def by_symbol_from_iex(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") { by_symbols_from_iex(symbol).first }
  end

  def by_symbols_from_iex(symbols)
    symbols = Array.wrap(symbols)
    companies = Allocator.iex_client.information_by_symbols(symbols: symbols, options: { types: "company" })
    companies.body.values.map do |company_response|
      company = _domain.from_iex_response(company_response[:company])
      company.exchange = ExchangeStore.new.by_id(company.exchange_id)
      company.issuer_type = IssuerTypeStore.new.by_code(company.issuer_type_code)
      company
    end
  end

  def index_companies_by_offset_limit(offset:, limit:)
    companies = _full_companies.offset(offset).limit(limit)
    _index_to_elasticsearch(companies)
  end

  def save_company(company_entity)
    company = Company.includes(:address, :company_executives)
                     .references(:address, :company_executives)
                     .where(symbol: company_entity.symbol).first
    company = CompanyBuilder.new(company).build_full_company_from_domain(company_entity)
    company.save!
    Rails.logger.info("Company saved: #{company_entity.symbol}")
    _index_to_elasticsearch(company)
    _domain.from_db_entity(company)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Company save failed: #{company_entity.symbol} with errors: #{e.message}")
    company = _domain.from_db_entity(e.record)
    raise AppExceptions::RecordInvalid.new(company)
  end

  def snp500_company_symbols_from_github
    Allocator.github_client.snp500_symbols.body.split
  end

  private

  def _domain
    Entities::Company
  end

  def _full_companies
    associations = %i[address company_executives exchange issuer_type]
    Company.includes(associations).references(associations)
  end

  def _index_to_elasticsearch(companies)
    companies = Array.wrap(companies)
    payload = companies.map do |company|
      entity = _domain.from_db_entity(company)
      serializer = CompanySerializer.from_domain_entity(entity)
      _index_bulk_payload(data: serializer.as_json, id: "#{_index_alias}-#{company.id}")
    end
    bulk_index(payload)
  end
end
