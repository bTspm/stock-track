class CompanyStore
  include ApiClients
  include Cacheable

  def by_symbol(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      company = Company.includes(:address, :company_executives, :exchange, :issuer_type)
                       .references(:address, :company_executives, :exchange, :issuer_type)
                       .where(symbol: symbol).first
      Entities::Company.from_db_entity(company)
    end
  end

  def by_symbol_from_iex(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      by_symbols_from_iex(symbol).first
    end
  end

  def by_symbols_from_iex(symbols)
    symbols = Array.wrap(symbols)
    companies = iex_client.information_by_symbols(symbols: symbols, options: { types: "company" })
    companies.body.values.map do |company_response|
      company = Entities::Company.from_iex_response(company_response[:company])
      company.exchange = ExchangeStore.new.by_name(company.exchange_name)
      company.issuer_type = IssuerTypeStore.new.by_code(company.issuer_type_code)
      company
    end
  end

  def save_company(company_entity)
    company = Company.includes(:address, :company_executives)
                     .references(:address, :company_executives)
                     .where(symbol: company_entity.symbol).first
    company = CompanyBuilder.new(company).build_full_company_from_domain(company_entity)
    company.save!
    Rails.logger.info("Company saved: #{company_entity.symbol}")
    Entities::Company.from_db_entity(company)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Company save failed: #{e.record.symbol} with errors: #{e.message}")
    company = Entities::Company.from_db_entity(e.record)
    raise AppExceptions::RecordInvalid.new(company)
  end

  def snp500_company_symbols_from_github
    response = Scraper::GithubClient.new.snp500_symbols
    response.body.split
  end
end
