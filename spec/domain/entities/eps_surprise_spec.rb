require "rails_helper"

describe Entities::EpsSurprise do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) { { actual: actual, date: date, estimate: estimate } }
  let(:actual) { double(:actual) }
  let(:date) { double(:date) }
  let(:estimate) { double(:estimate) }
  subject(:eps_surprise) { described_class.new(args) }

  describe ".from_finn_hub_response" do
    let(:args) { { actual: 4.99, date: converted_date, estimate: 4.641 } }
    let(:converted_date) { Date.new(2019, 12, 31) }
    let!(:response) { json_fixture("/api_responses/finn_hub/earnings.json").last }

    subject { described_class.from_finn_hub_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end

  describe "#surprise" do
    subject { eps_surprise.surprise }

    context "when actual is blank" do
      let(:actual) { nil }

      it { is_expected.to be_nil }
    end

    context "when estimate is blank" do
      let(:estimate) { nil }

      it { is_expected.to be_nil }
    end

    context "when both actual and estimate are present" do
      let(:actual) { 200 }
      let(:estimate) { 100 }

      it { is_expected.to eq 100 }
    end
  end

  describe "#surprise_percent" do
    subject { eps_surprise.surprise_percent }

    before { expect(eps_surprise).to receive(:surprise) { surprise } }

    context "when surprise is blank" do
      let(:surprise) { nil }

      it { is_expected.to be_nil }
    end

    context "when both surprise and estimate are present" do
      let(:surprise) { 5000 }
      let(:estimate) { 100 }

      it { is_expected.to eq 5_000 }
    end
  end
end
