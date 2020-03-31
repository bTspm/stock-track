class CompanyBuilder
  def initialize(company = nil)
    @company = company || Company.new
  end

  def build_full_company(company_entity)
    set_address(company_entity.address) if company_entity.address.line_1
    set_exchange_id(company_entity.exchange.id)
    set_issuer_type_id(company_entity.issuer_type.id)
    set_company_executives(company_entity.executives)

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
    return if executives.blank?

    executives_names_to_be_deleted = @company.company_executives.map(&:name) - executives.map(&:name)
    _delete_company_executives(executives_names_to_be_deleted) if executives_names_to_be_deleted.any?
    _update_or_add_company_executives(executives)
  end

  def set_exchange_id(exchange_id)
    @company.exchange_id = exchange_id
  end

  def set_issuer_type_id(issuer_type_id)
    @company.issuer_type_id = issuer_type_id
  end

  private

  def _new_company_executives(executives)
    executives.each do |executive|
      @company.company_executives << CompanyExecutiveBuilder.new.build_company_executive(executive)
    end
  end

  def _update_or_add_company_executives(executives)
    executives.each do |executive|
      existing_executive = _saved_executives_grouped_by_name[executive.name]&.first
      @company.association(:company_executives).add_to_target(
        CompanyExecutiveBuilder.new(existing_executive).build_company_executive(executive)
      )
    end
  end

  def _delete_company_executives(executives_names)
    executives_names.each do |name|
      @company.company_executives.detect{|executive| executive.name == name }.mark_for_destruction
    end
  end

  def _saved_executives_grouped_by_name
    @_executives_grouped_by_name ||= @company.company_executives.group_by(&:name)
  end
end
