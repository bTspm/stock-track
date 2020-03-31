class CompanyStore
  def companies_by_symbols_from_iex(symbols)
    symbols = Array.wrap(symbols)
    companies = _client.information_by_symbols(symbols: symbols, options: {types: "company"})
    companies.body.values.map do |company_response|
      company = Entities::Company.from_iex_response(company_response[:company])
      company.exchange = ExchangeStore.new.by_name(company.exchange.name)
      company.issuer_type = IssuerTypeStore.new.by_code(company.issuer_type.code)
      company
    end
  end

  def by_symbol(symbol)
    company = ::Company.includes(:address, :company_executives, :exchange, :issuer_type)
                  .references(:address, :company_executives, :exchange, :issuer_type)
                  .where(symbol: symbol).first
    Entities::Company.from_db_entity(company)
  end

  def by_symbol_from_iex(symbol)
    companies_by_symbols_from_iex(symbol).first
  end

  def save_company(company_entity)
    company = Company.includes(:address, :company_executives, :exchange, :issuer_type)
                  .references(:address, :company_executives, :exchange, :issuer_type)
                  .where(symbol: company_entity.symbol).first
    company = CompanyBuilder.new(company).build_full_company(company_entity)
    company.save!
    Entities::Company.from_db_entity(company)
  end

  private

  def _client
    Api::Iex::Client.new
  end

  def _finn_hub_client
    Api::FinnHub::Client.new
  end
end
