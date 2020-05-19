class CompanyExecutiveBuilder < BaseBuilder
  protected

  def _base_column_names
    Entities::CompanyExecutive::BASE_ATTRIBUTES
  end

  def _db_entity_class
    CompanyExecutive
  end
end
