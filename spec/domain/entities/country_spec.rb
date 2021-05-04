require "rails_helper"

describe Entities::Country do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) { { alpha2: alpha2, code: code, name: name } }
  let(:alpha2) { double(:alpha2) }
  let(:code) { double(:code) }
  let(:name) { double(:name) }
  subject(:country) { described_class.new(args) }

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

  describe "#usa?" do
    subject { country.usa? }

    context "when country is usa" do
      let(:code) { described_class::USA_CODE }

      it { is_expected.to eq true }
    end

    context "when country is not usa" do
      let(:code) { "ABC" }

      it { is_expected.to eq false }
    end

    context "when country code is nil" do
      let(:code) { nil }

      it { is_expected.to eq false }
    end
  end
end
