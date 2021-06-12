require "rails_helper"

describe QuotesPresenter do
  describe ".scalar" do
    let(:quote) { build :entity_quote }
    subject(:presenter) { described_class::Scalar.new(quote, view_context) }

    describe "#change_and_change_percent" do
      subject { presenter.change_and_change_percent }

      it "expect to return change and change percent" do
        expect(presenter).to receive(:change) { "Change" }
        expect(presenter).to receive(:change_percent) { "Change Percent" }
        expect(view_context).to receive(:content_color_by_value).with(
          content: "Change (Change Percent)",
          value: 100
        ) { "Colored Change" }

        expect(subject).to eq "Colored Change"
      end
    end

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

    describe "#high" do
      subject { presenter.high }

      it "expect to call st_number_to_currency with high" do
        expect(view_context).to receive(:st_number_to_currency).with(300_000) { "high" }

        expect(subject).to eq "high"
      end
    end

    describe "#low" do
      subject { presenter.low }

      it "expect to call st_number_to_currency with low" do
        expect(view_context).to receive(:st_number_to_currency).with(600_000) { "low" }

        expect(subject).to eq "low"
      end
    end

    describe "#open" do
      subject { presenter.open }

      it "expect to call st_number_to_currency with open" do
        expect(view_context).to receive(:st_number_to_currency).with(700_000) { "open" }

        expect(subject).to eq "open"
      end
    end

    describe "#previous_close" do
      subject { presenter.previous_close }

      it "expect to call st_number_to_currency with previous_close" do
        expect(view_context).to receive(:st_number_to_currency).with(800_000) { "previous_close" }

        expect(subject).to eq "previous_close"
      end
    end

    describe "#price" do
      subject { presenter.price }

      it "expect to call st_number_to_currency with price" do
        expect(view_context).to receive(:st_number_to_currency).with(100_000) { "Price" }

        expect(subject).to eq "Price"
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

      it "expect to call st_number_to_human with volume" do
        expect(view_context).to receive(:st_number_to_human).with(1_000_000) { "Volume" }

        expect(subject).to eq "Volume"
      end
    end
  end
end
