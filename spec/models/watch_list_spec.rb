require "rails_helper"

describe WatchList, type: :model do
  describe "associations" do
    context "belongs_to" do
      it { should belong_to(:user).required }
    end
  end

  describe "validations" do
    context "presence" do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:user_id) }
      it { should validate_presence_of(:symbols).on(:create) }
    end

    context "uniqueness" do
      subject { FactoryBot.create(:watch_list) }
      it { should validate_uniqueness_of(:name).scoped_to(:user_id).ignoring_case_sensitivity }
    end
  end
end
