class ExchangeBuilder < BaseBuilder
  protected

  def _base_column_names
    Entities::Exchange::BASE_ATTRIBUTES
  end

  def _model_class
    Exchange
  end
end
