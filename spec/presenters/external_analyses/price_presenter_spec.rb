require "rails_helper"

describe ExternalAnalyses::PriceTargetPresenter do
  describe ".scalar" do
    let(:price_target) { double(:price_target, low: 100_000, high: 250_000, average: 200_000) }
    subject(:presenter) { described_class::Scalar.new(price_target, view_context) }

    describe "#chart_data" do
      subject { presenter.chart_data }

      it "expect to return chart data" do
        expect(subject).to eq [100_000, 200_000, 250_000]
      end
    end

    describe "#low" do
      subject { presenter.low }

      it "expect to format" do
        expect(view_context).to receive(:number_with_delimiter).with(100_000) { "Low" }

        subject
      end
    end

    describe "#average" do
      subject { presenter.average }

      it "expect to format" do
        expect(view_context).to receive(:number_with_delimiter).with(200_000) { "Avg" }

        subject
      end
    end

    describe "#high" do
      subject { presenter.high }

      it "expect to format" do
        expect(view_context).to receive(:number_with_delimiter).with(250_000) { "High" }

        subject
      end
    end
  end
end
