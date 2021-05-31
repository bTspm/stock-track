require "rails_helper"

describe QuotesPresenter do
  describe ".scalar" do
    let(:quote) { build :entity_quote }
    subject(:presenter) { described_class::Scalar.new(quote, view_context) }

    describe "#change" do
      subject { presenter.change }

      it "expect to return formatted change" do
        expect(
          view_context
        ).to receive(:content_color_by_value).with(content: "100", value: quote.change) { "Formatted Content" }

        expect(subject).to eq "Formatted Content"
      end
    end

    describe "#change_percent" do
      subject { presenter.change_percent }

      it "expect to return formatted change_percent" do
        expect(view_context).to receive(:content_color_by_value).with(
          content: "10.00%",
          value: quote.change_percent
        ) { "Formatted Content" }

        expect(subject).to eq "Formatted Content"
      end
    end

    describe "#day_range" do
      subject { presenter.day_range }

      context "without high and low" do
        let(:quote) { build :entity_quote, high: nil, low: nil }

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
        let(:quote) { build :entity_quote, low: nil }

        it "expect to return high and low as N/A" do
          expect(view_context).to receive(:positive_content).with("300,000") { "High" }
          expect(view_context).to receive(:negative_content).with("N/A") { "N/A" }

          expect(subject).to eq "N/A - High"
        end
      end

      context "without high and with low" do
        let(:quote) { build :entity_quote, high: nil }

        it "expect to return high as N/A and low" do
          expect(view_context).to receive(:positive_content).with("N/A") { "N/A" }
          expect(view_context).to receive(:negative_content).with("600,000") { "Low" }

          expect(subject).to eq "Low - N/A"
        end
      end
    end

    describe "#open" do
      subject { presenter.open }

      context "without open" do
        let(:quote) { build :entity_quote, open: nil }

        it { is_expected.to eq "N/A" }
      end

      context "with open" do
        it { is_expected.to eq "700,000" }
      end
    end

    describe "#previous_close" do
      subject { presenter.previous_close }

      context "without previous_close" do
        let(:quote) { build :entity_quote, previous_close: nil }

        it { is_expected.to eq "N/A" }
      end

      context "with previous_close" do
        it { is_expected.to eq "800,000" }
      end
    end

    describe "#price" do
      subject { presenter.price }

      it { is_expected.to eq "100,000" }
    end

    describe "#price_color" do
      subject { presenter.price_color }

      it "expect to return price_color" do
        expect(view_context).to receive(:price_color_class).with(quote.change) { "Price Color" }

        expect(subject).to eq "Price Color"
      end
    end

    describe "#price_icon" do
      subject { presenter.price_icon }

      it "expect to return price_icon" do
        expect(view_context).to receive(:price_icon).with(quote.change) { "Price Icon" }

        expect(subject).to eq "Price Icon"
      end
    end

    describe "#source" do
      subject { presenter.source }

      it { is_expected.to eq "Iex" }
    end

    describe "#updated_at" do
      subject { presenter.updated_at }

      it { is_expected.to eq "Updated Dec 31, 2018 7:00:00 PM" }
    end

    describe "#volume" do
      subject { presenter.volume }

      context "without volume" do
        let(:quote) { build :entity_quote, volume: nil }

        it { is_expected.to eq "N/A" }
      end

      context "with volume" do
        it { is_expected.to eq "1 M" }
      end
    end
  end
end
