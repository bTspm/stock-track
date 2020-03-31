class CompanyService < BusinessService
  include Services

  def company_by_symbol(symbol)
    company_storage.company_by_symbol(symbol)
  end

  def create_or_update_company_by_symbol(symbol)
    company = company_storage.by_symbol_from_iex(symbol)
    company.executives = company_executive_storage.executives_by_symbol_from_finn_hub(symbol)
    company_storage.save_company(company)
  end

  def executives_by_symbol(symbol)
    company_executive_storage.executives_by_symbol(symbol)
  end
end
