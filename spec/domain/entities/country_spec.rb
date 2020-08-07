require "rails_helper"

describe Entities::Country do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) { { alpha2: alpha2, code: code, name: name } }
  let(:alpha2) { double(:alpha2) }
  let(:code) { double(:code) }
  let(:name) { double(:name) }

  describe ".from_code" do
    subject { described_class.from_code(code) }

    context "without country" do
      let(:code) { "123" }
      it { is_expected.to be_nil }
    end

    context "with country" do
      let(:args) { { alpha2: "US", code: "USA", name: "United States of America" } }
      let(:code) { "US" }
      it "expect to create an entity with args" do
        expect(described_class).to receive(:new).with(args)

        subject
      end
    end
  end
end
