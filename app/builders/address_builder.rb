class AddressBuilder < BaseBuilder
  def build_full_address_from_domain(entity)
    build do |builder|
      builder.build_base_entity_from_domain(entity)
      builder.set_country(entity.country_alpha2)
      builder.set_state(entity.state_code)
    end
  end

  def set_country(code)
    @db_entity.country = code
  end

  def set_state(code)
    @db_entity.state = code
  end

  protected

  def _base_column_names
    %i[city
       line_1
       line_2
       zip_code].freeze
  end

  def _model_class
    Address
  end
end
