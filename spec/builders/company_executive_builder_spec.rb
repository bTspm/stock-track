require "rails_helper"

describe CompanyExecutiveBuilder do
  it_behaves_like "BaseBuilder#initialize"
  it_behaves_like "BaseBuilder#build"
  it_behaves_like "BaseBuilder#build_base_entity_from_domain"
end
