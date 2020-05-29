class AddressBuilder < BaseBuilder
  protected

  def _base_column_names
    Entities::Address::BASE_ATTRIBUTES
  end

  def _model_class
    Address
  end
end
