class CompanyExecutiveBuilder

  def initialize(company_executive = nil)
    @company_executive = company_executive || CompanyExecutive.new
  end

  def build_company_executive(company_executive_entity)
    @company_executive.tap do |ce|
      ce.age = company_executive_entity.age
      ce.name = company_executive_entity.name
      ce.since = company_executive_entity.since
      ce.titles = company_executive_entity.titles
    end
  end
end
