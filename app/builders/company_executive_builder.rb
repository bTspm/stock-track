class CompanyExecutiveBuilder

  def initialize(company_executive = nil)
    @company_executive = company_executive || CompanyExecutive.new
  end

  def build_company_executive(company_executive_entity)
    @company_executive.tap do |a|
      a.line_1 = company_executive_entity.line_1
      a.line_2 = company_executive_entity.line_2
      a.city = company_executive_entity.city
      a.state = company_executive_entity.state
      a.country = company_executive_entity.country
      a.zip_code = company_executive_entity.zip_code
    end
  end
end
