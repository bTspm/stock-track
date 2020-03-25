class CompanyService < BusinessService
  include Services

  def company_by_symbol(symbol)
    company_storage.company_by_symbol(symbol)
  end

  def create_or_update_company_by_symbol(symbol)
    company = company_storage.by_symbol_from_iex(symbol)
    company_storage.save_company(company)
  end

  def company_executives_by_symbol(symbol)
    company_storage.executives_by_symbol_from_finn_hub(symbol)
  end
end
