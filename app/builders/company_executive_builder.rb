class CompanyExecutiveBuilder < BaseBuilder
  protected

  def _base_column_names
    Entities::CompanyExecutive::BASE_ATTRIBUTES
  end

  def _model_class
    CompanyExecutive
  end
end
