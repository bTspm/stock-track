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
          expect(result[:data]).to eq [5_000, 1_000, 100_000, 600, 300, 100, 5]
          expect(result[:xaxis_titles]).to eq %w[5Y 1Y YTD 6M 3M 1M 5D]
        end
      end

      context "when a value is nil" do
        let(:ytd) { nil }

        it "expect to return chart data with nil" do
          result = subject
          expect(result[:data]).to eq [5_000, 1_000, nil, 600, 300, 100, 5]
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
        it { is_expected.to include "100,000.00%" }
      end
    end
  end
end
