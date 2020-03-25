class CompanyBuilder
  def initialize(company = nil)
    @company = company || Company.new
  end

  def build_full_company(company_entity)
    set_address(company_entity.address) if company_entity.address.line_1
    set_exchange_id(company_entity.exchange.id)
    set_issuer_type_id(company_entity.issuer_type.id)

    @company.tap do |c|
      c.symbol = company_entity.symbol
      c.name = company_entity.name
      c.security_name = company_entity.security_name
      c.sector = company_entity.sector
      c.industry = company_entity.industry
      c.employees = company_entity.employees
      c.website = company_entity.website
      c.description = company_entity.description
      c.sic_code = company_entity.sic_code
    end
  end

  def set_address(address_entity)
    @company.address = AddressBuilder.new(@company.address).build_address(address_entity)
  end

  def set_company_executives(executives)
    executives.each do |executive|

      @company.company_executives << CompanyExecutiveBuilder.new(@company).build_company_executive(executive)
    end
  end

  def set_exchange_id(exchange_id)
    @company.exchange_id = exchange_id
  end

  def set_issuer_type_id(issuer_type_id)
    @company.issuer_type_id = issuer_type_id
  end
end
