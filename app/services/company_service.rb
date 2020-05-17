class CompanyService < BusinessService
  include Services

  def company_by_symbol(symbol)
    company = company_storage.by_symbol(symbol)
    return company if company

    create_or_update_company_by_symbol(symbol)
  end

  def create_or_update_company_by_symbol(symbol)
    company = company_storage.by_symbol_from_iex(symbol)
    company.executives = company_executive_storage.by_symbol_from_finn_hub(symbol)
    company_storage.save_company(company)
  end

  def create
    symbols = company_executive_storage.symbols_by_exchange("US")
    symbols.each_with_index do |s, i|
      t = i * 1
      CompanyWorker.perform_in(t, s)
    end
  end
end
