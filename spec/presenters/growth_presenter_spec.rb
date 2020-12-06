require "rails_helper"

describe GrowthPresenter do
  describe ".scalar" do
    let(:object) { build(:entity_growth, ytd: ytd) }
    let(:ytd) { 100_000  }
    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#chart_data" do
      subject { JSON.parse(presenter.chart_data).with_indifferent_access }

      context "with values" do
        it "expect to return chart data" do
          result = subject
          expect(result[:data]).to eq [500_000, 100_000, 10_000_000, 60_000, 30_000, 10_000, 500]
          expect(result[:xaxis_titles]).to eq %w[5Y 1Y YTD 6M 3M 1M 5D]
        end
      end

      context "when a value is nil" do
        let(:ytd) { nil }

        it "expect to return chart data with nil" do
          result = subject
          expect(result[:data]).to eq [500_000, 100_000, nil, 60_000, 30_000, 10_000, 500]
          expect(result[:xaxis_titles]).to eq %w[5Y 1Y YTD 6M 3M 1M 5D]
        end
      end
    end

    describe "#formatted_ytd" do
      subject { presenter.formatted_ytd }

      context "without ytp" do
        let(:ytd) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "with ytd" do
        it { is_expected.to include "10,000,000%" }
      end
    end
  end
end
