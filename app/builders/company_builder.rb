class CompanyBuilder < BaseBuilder
  def build_full_company(company_entity)
    build_base_entity(company_entity)
    set_address(company_entity.address) if company_entity.address.line_1
    set_exchange_id(company_entity.exchange.id)
    set_issuer_type_id(company_entity.issuer_type.id)
    set_company_executives(company_entity.executives)
  end

  def set_address(address_entity)
    @db_entity.address = AddressBuilder.new(@db_entity.address).build_base_entity(address_entity)
    @db_entity
  end

  def set_company_executives(executives)
    if executives.any?
      executives_names_to_be_deleted = @db_entity.company_executives.map(&:name) - executives.map(&:name)
      _delete_company_executives(executives_names_to_be_deleted) if executives_names_to_be_deleted.any?
      _update_or_add_company_executives(executives)
    end
    @db_entity
  end

  def set_exchange_id(exchange_id)
    @db_entity.exchange_id = exchange_id
    @db_entity
  end

  def set_issuer_type_id(issuer_type_id)
    @db_entity.issuer_type_id = issuer_type_id
    @db_entity
  end

  def _base_column_names
    Entities::Company::BASE_ATTRIBUTES
  end

  def _db_entity_class
    Company
  end

  private

  def _new_company_executives(executives)
    executives.each do |executive|
      @db_entity.company_executives << CompanyExecutiveBuilder.new.build_base_entity(executive)
    end
  end

  def _update_or_add_company_executives(executives)
    executives.each do |executive|
      existing_executive = _saved_executives_grouped_by_name[executive.name]&.first
      @db_entity.association(:company_executives).add_to_target(
       CompanyExecutiveBuilder.new(existing_executive).build_base_entity(executive)
      )
    end
  end

  def _delete_company_executives(executives_names)
    executives_names.each do |name|
      @db_entity.company_executives.detect { |executive| executive.name == name }.mark_for_destruction
    end
  end

  def _saved_executives_grouped_by_name
    @_executives_grouped_by_name ||= @db_entity.company_executives.group_by(&:name)
  end
end
