class CompanyStore
  include Allocator::ApiClients

  def by_symbols_from_iex(symbols)
    symbols = Array.wrap(symbols)
    companies = iex_client.information_by_symbols(symbols: symbols, options: {types: "company"})
    companies.body.values.map do |company_response|
      company = Entities::Company.from_iex_response(company_response[:company])
      company.exchange = ExchangeStore.new.by_name(company.exchange_name)
      company.issuer_type = IssuerTypeStore.new.by_code(company.issuer_type_code)
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
    by_symbols_from_iex(symbol).first
  end

  def save_company(company_entity)
    company = Company.includes(:address, :company_executives, :exchange, :issuer_type)
                  .references(:address, :company_executives, :exchange, :issuer_type)
                  .where(symbol: company_entity.symbol).first
    company = CompanyBuilder.build_full_company(db_entity: company, domain_entity: company_entity)
    company.save!
    Rails.logger.info("Company saved: #{company.symbol}")
    Entities::Company.from_db_entity(company)
  end
end
