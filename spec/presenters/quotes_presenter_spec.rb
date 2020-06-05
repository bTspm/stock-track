require "rails_helper"

describe QuotesPresenter do
  describe ".scalar" do
    let(:args) do
      {
       change: change,
       change_percent: change_percent,
       close: close,
       extended_change: extended_change,
       extended_change_percent: extended_change_percent,
       extended_price: extended_price,
       extended_time: extended_time,
       high: high,
       is_us_market_open: is_us_market_open,
       latest_price: latest_price,
       latest_source: latest_source,
       latest_update: latest_update,
       latest_volume: latest_volume,
       low: low,
       open: open,
       previous_close: previous_close,
       previous_volume: previous_volume,
       volume: volume,
      }
    end
    let(:change) { 100_000 }
    let(:change_percent) { 0.023 }
    let(:close) { 200_000 }
    let(:extended_change) { 1_000 }
    let(:extended_change_percent) { 2_000 }
    let(:extended_price) { 3_000 }
    let(:extended_time) { DateTime.new(2020, 06, 01, 05, 00, 00) }
    let(:high) { 300_000 }
    let(:is_us_market_open) { true }
    let(:latest_price) { 400_000 }
    let(:latest_source) { "Source Name" }
    let(:latest_update) { DateTime.new(2020, 05, 01, 05, 00, 00) }
    let(:latest_volume) { 500_000 }
    let(:low) { 600_000 }
    let(:object) { double(:object, args) }
    let(:open) { 700_000 }
    let(:previous_close) { 800_000 }
    let(:previous_volume) { 900_000 }
    let(:volume) { 1_000_000 }

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#day_range" do
      subject { presenter.day_range }

      context "without high and low" do
        let(:high) { nil }
        let(:low) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "with high and low" do
        it "expect to return low and high" do
          expect(view_context).to receive(:positive_content).with("300,000") { "High" }
          expect(view_context).to receive(:negative_content).with("600,000") { "Low" }

          expect(subject).to eq "Low - High"
        end
      end

      context "with high and without low" do
        let(:low) { nil }

        it "expect to return high and low as N/A" do
          expect(view_context).to receive(:positive_content).with("300,000") { "High" }
          expect(view_context).not_to receive(:negative_content)

          expect(subject).to eq "N/A - High"
        end
      end

      context "without high and with low" do
        let(:high) { nil }

        it "expect to return high as N/A and low" do
          expect(view_context).not_to receive(:positive_content)
          expect(view_context).to receive(:negative_content).with("600,000") { "Low" }

          expect(subject).to eq "Low - N/A"
        end
      end
    end

    describe "#extended_price_info" do
      let(:extended_price) { double(:extended_price) }

      subject { presenter.extended_price_info }

      it "expect to init an extended price and init price presenter" do
        expect(OpenStruct).to receive(:new).with(
         amount: extended_price,
         change: extended_change,
         change_percent: extended_change_percent,
         source: "Extended",
         time: extended_time
        ) { extended_price }
        expect(PricePresenter).to receive(:present).with(extended_price, view_context) { "Extended Price" }

        expect(subject).to eq "Extended Price"
      end
    end

    describe "#latest_price_info" do
      let(:latest_price) { double(:latest_price) }

      subject { presenter.latest_price_info }

      it "expect to init an latest price and init price presenter" do
        expect(OpenStruct).to receive(:new).with(
         amount: latest_price,
         change: change,
         change_percent: change_percent,
         source: latest_source,
         time: latest_update
        ) { latest_price }
        expect(PricePresenter).to receive(:present).with(latest_price, view_context) { "Latest Price" }

        expect(subject).to eq "Latest Price"
      end
    end

    describe "#open" do
      subject { presenter.open }

      context "without open" do
        let(:open) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "with open" do
        it { is_expected.to eq "700,000" }
      end
    end

    describe "#previous_close" do
      subject { presenter.previous_close }

      context "without previous_close" do
        let(:previous_close) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "with previous_close" do
        it { is_expected.to eq "800,000" }
      end
    end

    describe "#previous_volume" do
      subject { presenter.previous_volume }

      context "without previous_volume" do
        let(:previous_volume) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "with previous_volume" do
        it { is_expected.to eq "900,000" }
      end
    end

    describe "#show_extended_info?" do
      subject { presenter.show_extended_info? }

      context "when us market is open" do
        let(:is_us_market_open) { true }

        it { is_expected.to be_falsey }
      end

      context "when there is no extended" do
        let(:extended_change) { nil }
        let(:extended_change_percent) { nil }
        let(:extended_price) { nil }

        it { is_expected.to be_falsey }
      end

      context "when market is closed and has extended info" do
        let(:is_us_market_open) { false }

        it { is_expected.to be_truthy }
      end
    end

    describe "#volume" do
      subject { presenter.volume }

      context "without volume" do
        let(:volume) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "with volume" do
        it { is_expected.to eq "1,000,000" }
      end
    end
  end
end
