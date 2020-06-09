require "rails_helper"

describe Exchange, type: :model do
  describe "associations" do
    context "belongs_to" do
      it { should have_many(:companies) }
    end
  end

  describe "validations" do
    context "presence" do
      it { should validate_presence_of(:code) }
      it { should validate_presence_of(:country) }
      it { should validate_presence_of(:name) }
    end

    context "uniqueness" do
      subject { FactoryBot.create(:exchange) }
      it { should validate_uniqueness_of(:code).scoped_to(:country).ignoring_case_sensitivity }
    end
  end
end
