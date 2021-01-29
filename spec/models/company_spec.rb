require "rails_helper"

describe Company, type: :model do
  describe "associations" do
    context "belongs_to" do
      it { should belong_to(:address).optional }
      it { should belong_to(:exchange).required }
      it { should belong_to(:issuer_type).required }
    end

    context "has_many" do
      it { should have_many(:company_executives).autosave(true) }
    end
  end

  describe "validations" do
    context "presence" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:security_name) }
      it { should validate_presence_of(:symbol) }
    end

    context "uniqueness" do
      subject { FactoryBot.create(:company) }
      it { should validate_uniqueness_of(:symbol).scoped_to(:exchange_id).ignoring_case_sensitivity }
    end
  end
end
