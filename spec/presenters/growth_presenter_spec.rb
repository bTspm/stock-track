require "rails_helper"

describe GrowthPresenter do
  describe ".scalar" do
    let(:args) do
      {
       day_5: day_5,
       month_1: 0.0818,
       month_3: -0.0354,
       month_6: 0.1578,
       year_1: 0.6117,
       year_5: 1.3896,
       ytd: 0.0387
      }
    end
    let(:day_5) { -0.0232 }
    let(:object) { double(:object, args) }

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#chart_data" do
      subject { JSON.parse(presenter.chart_data).with_indifferent_access }

      context "with values" do
        it "expect to return chart data" do
          result = subject
          expect(result[:data]).to eq [138.96, 61.17, 3.87, 15.78, -3.54, 8.18, -2.32]
          expect(result[:xaxis_titles]).to eq %w(5Y 1Y YTD 6M 3M 1M 5D)
        end
      end

      context "when a value is nil" do
        let(:day_5) { nil }
        it "expect to return chart data with nil" do
          result = subject
          expect(result[:data]).to eq [138.96, 61.17, 3.87, 15.78, -3.54, 8.18, nil]
          expect(result[:xaxis_titles]).to eq %w(5Y 1Y YTD 6M 3M 1M 5D)
        end
      end
    end
  end
end
