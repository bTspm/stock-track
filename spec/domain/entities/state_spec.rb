require "rails_helper"

describe Entities::State do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) { { code: code, name: name } }
  let(:code) { double(:code) }
  let(:name) { double(:name) }

  describe ".from_code" do
    let(:code) { "NH" }
    let(:country_code) { "US" }
    subject { described_class.from_code(code: code, country_code: country_code) }

    context "without code" do
      let(:code) { nil }
      it { is_expected.to be_nil }
    end

    context "without country_code" do
      let(:country_code) { "123" }
      it { is_expected.to be_nil }
    end

    context "without country" do
      let(:country_code) { "123" }
      it { is_expected.to be_nil }
    end

    context "with country and without state" do
      let(:args) { { code: "123", name: "123" } }
      let(:code) { "123" }
      it "expect to create an entity with args" do
        expect(described_class).to receive(:new).with(args)

        subject
      end
    end

    context "with country and state" do
      let(:args) { { code: "NH", name: "New Hampshire" } }
      it "expect to create an entity with args" do
        expect(described_class).to receive(:new).with(args)

        subject
      end
    end
  end
end
