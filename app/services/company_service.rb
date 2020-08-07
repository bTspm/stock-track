class CompanyService < BusinessService
  include Services

  def basic_search(search_text)
    company_storage.basic_search_from_es(search_text)
  end

  def company_by_symbol(symbol)
    company = company_storage.by_symbol(symbol)
    return company if company

    save_company_by_symbol(symbol)
  end

  def index_companies(offset:, limit:)
    company_storage.index_companies_by_offset_limit(offset: offset, limit: limit)
  end

  def save_company_by_symbol(symbol)
    company = company_storage.by_symbol_from_iex(symbol)
    company.company_executives = company_executive_storage.by_symbol_from_finn_hub(symbol)
    company_storage.save_company(company)
  end

  def snp500_company_symbols
    company_storage.snp500_company_symbols_from_github
  end
end
