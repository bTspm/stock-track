class CompanyService < BusinessService
  include Services

  def company_by_symbol(symbol)
    company = company_storage.by_symbol(symbol)
    return company if company

    save_company_by_symbol(symbol)
  end

  def save_company_by_symbol(symbol)
    company = company_storage.by_symbol_from_iex(symbol)
    company.executives = company_executive_storage.by_symbol_from_finn_hub(symbol)
    company_storage.save_company(company)
  end

  def snp500_company_symbols
    company_storage.snp500_company_symbols_from_github
  end
end
