require "rails_helper"

describe IssuerType, type: :model do
  describe "associations" do
    context "belongs_to" do
      it { should have_many(:companies) }
    end
  end

  describe "validations" do
    context "presence" do
      it { should validate_presence_of(:code) }
      it { should validate_presence_of(:name) }
    end

    context "uniqueness" do
      subject { FactoryBot.create(:issuer_type) }
      it { should validate_uniqueness_of(:code).ignoring_case_sensitivity }
      it { should validate_uniqueness_of(:name).ignoring_case_sensitivity }
    end
  end
end
