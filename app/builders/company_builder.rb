class CompanyBuilder < BaseBuilder
  def self.build_full_company(db_entity:, domain_entity:)
    build(db_entity) do |builder|
      builder.build_base_entity_from_domain(domain_entity)
      builder.set_address(domain_entity.address) if domain_entity.line_1
      builder.set_company_executives(domain_entity.executives)
      builder.set_exchange_id(domain_entity.exchange_id)
      builder.set_issuer_type_id(domain_entity.issuer_type_id)
    end
  end

  def set_address(address)
    @db_entity.address = AddressBuilder.build(@db_entity.address) do |builder|
      builder.build_base_entity_from_domain(address)
    end
  end

  def set_company_executives(executives)
    return if executives.blank?

    executives_names_to_be_deleted = @db_entity.company_executives.map(&:name) - executives.map(&:name)
    _delete_company_executives(executives_names_to_be_deleted) if executives_names_to_be_deleted.any?
    _update_or_add_company_executives(executives)
  end

  def set_exchange_id(exchange_id)
    @db_entity.exchange_id = exchange_id
  end

  def set_issuer_type_id(issuer_type_id)
    @db_entity.issuer_type_id = issuer_type_id
  end

  protected

  def _base_column_names
    Entities::Company::BASE_ATTRIBUTES
  end

  def _model_class
    Company
  end

  private

  def _add_to_association(executives)
    @db_entity.association(:company_executives).add_to_target(executives)
  end

  def _delete_company_executives(executives_names)
    executives_names.each do |name|
      @db_entity.company_executives.detect { |executive| executive.name == name }.mark_for_destruction
    end
  end

  def _saved_executives_grouped_by_name
    @_executives_grouped_by_name ||= @db_entity.company_executives.group_by(&:name)
  end

  def _update_or_add_company_executives(executives)
    built_executives = executives.map do |executive|
      existing_executive = _saved_executives_grouped_by_name[executive.name]&.first
      CompanyExecutiveBuilder.build(existing_executive) do |builder|
        builder.build_base_entity_from_domain(executive)
      end
    end

    _add_to_association(built_executives)
  end
end
