require "rails_helper"

describe Entities::Stock do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) do
    {
      company: company,
      earnings: earnings,
      external_analysis: external_analysis,
      growth: growth,
      quote: quote,
      stats: stats,
      time_series: time_series,
    }
  end
  let(:company) { double(:company) }
  let(:earnings) { double(:earnings) }
  let(:external_analysis) { double(:external_analysis) }
  let(:growth) { double(:growth) }
  let(:quote) { double(:quote) }
  let(:stats) { double(:stats) }
  let(:time_series) { double(:time_series) }
  let(:stock) { described_class.new(args) }

  describe "#latest_earnings" do
    subject { stock.latest_earnings }

    context "when earnings available" do
      let(:earnings2020) { build :entity_eps_surprise }
      let(:earnings2021) { build :entity_eps_surprise }
      let(:earnings) { [earnings2020, earnings2021] }

      it "expect to return the most recent earnings by date" do
        expect(subject).to eq earnings2021
      end
    end

    context "when earnings not available" do
      let(:earnings) { [] }

      it { is_expected.to be_nil }
    end
  end
end
