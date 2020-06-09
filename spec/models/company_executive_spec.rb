require "rails_helper"

describe CompanyExecutive, type: :model do
  describe 'associations' do
    context "belongs_to" do
      it { should belong_to(:company).required.dependent(:destroy) }
    end
  end

  describe "validations" do
    context "presence" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:titles) }
    end
  end
end
