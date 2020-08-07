class CompanyExecutiveBuilder < BaseBuilder
  protected

  def _base_column_names
    %i[age
       compensation
       currency
       name
       since
       titles].freeze
  end

  def _model_class
    CompanyExecutive
  end
end
