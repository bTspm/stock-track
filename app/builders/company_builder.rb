class CompanyBuilder < BaseBuilder
  def build_full_company_from_domain(entity)
    build do |builder|
      builder.build_base_entity_from_domain(entity)
      builder.set_address(entity.address) if entity.line_1
      builder.set_company_executives(entity.company_executives)
      builder.set_exchange_id(entity.exchange_id)
      builder.set_issuer_type_id(entity.issuer_type_id)
      builder.set_ratings(entity.ratings)
    end
  end

  def set_address(address)
    @db_entity.address = AddressBuilder.new(@db_entity.address).build do |builder|
      builder.build_full_address_from_domain(address)
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

  def set_ratings(ratings)
    @db_entity.ratings = ratings.to_json
  end

  protected

  def _base_column_names
    %i[description
       employees
       industry
       name
       phone
       sector
       security_name
       sic_code
       symbol
       website].freeze
  end

  def _model_class
    Company
  end

  private

  def _add_to_association(executive)
    @db_entity.association(:company_executives).add_to_target(executive)
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
    executives.map do |executive|
      existing_executive = _saved_executives_grouped_by_name[executive.name]&.first
      CompanyExecutiveBuilder.new(existing_executive).build do |builder|
        _add_to_association(builder.build_base_entity_from_domain(executive))
      end
    end
  end
end
