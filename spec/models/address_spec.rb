require "rails_helper"

describe Address, type: :model do
  describe "validations" do
    context "presence" do
      it { should validate_presence_of(:country) }
      it { should validate_presence_of(:line_1) }
    end
  end
end
