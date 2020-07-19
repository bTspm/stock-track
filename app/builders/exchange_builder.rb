class ExchangeBuilder < BaseBuilder
  def build_full_exchange_from_domain(entity)
    build do |builder|
      builder.build_base_entity_from_domain(entity)
      builder.set_country(entity.country_alpha2)
    end
  end

  def set_country(code)
    @db_entity.country = code
  end

  protected

  def _base_column_names
    Entities::Exchange::BASE_ATTRIBUTES
  end

  def _model_class
    Exchange
  end
end
