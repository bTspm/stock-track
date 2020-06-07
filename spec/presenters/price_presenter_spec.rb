require "rails_helper"

describe PricePresenter do
  describe ".scalar" do
    let(:args) do
      {
        amount: 100_000,
        change: change,
        change_percent: change_percent,
        source: source,
        time: DateTime.new(2020, 0o5, 0o1)
      }
    end
    let(:change) { 2_000 }
    let(:change_percent) { 0.0818 }
    let(:object) { double(:object, args) }
    let(:source) { "Source" }

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#amount" do
      subject { presenter.amount }

      it { is_expected.to eq "100,000" }
    end

    describe "#change" do
      subject { presenter.change }

      it "expect to return formatted change" do
        expect(
          view_context
        ).to receive(:content_color_by_value).with(content: "2,000", value: change) { "Formatted Content" }

        expect(subject).to eq "Formatted Content"
      end
    end

    describe "#change_percent" do
      subject { presenter.change_percent }

      it "expect to return formatted change_percent" do
        expect(
          view_context
        ).to receive(:content_color_by_value).with(content: "(8.18%)", value: change_percent) { "Formatted Content" }

        expect(subject).to eq "Formatted Content"
      end
    end

    describe "#last_updated" do
      subject { presenter.last_updated }

      it { is_expected.to eq "Apr 30, 2020 8:00:00 PM" }
    end

    describe "#price_color" do
      subject { presenter.price_color }

      it "expect to return price_color" do
        expect(view_context).to receive(:price_color_class).with(change) { "Price Color" }

        expect(subject).to eq "Price Color"
      end
    end

    describe "#price_icon" do
      subject { presenter.price_icon }

      it "expect to return price_icon" do
        expect(view_context).to receive(:price_icon).with(change) { "Price Icon" }

        expect(subject).to eq "Price Icon"
      end
    end

    describe "#source" do
      let(:badge_color) { "ABC" }
      let(:options) { { badge_color: badge_color } }
      subject { presenter.source }

      before :each do
        expect(view_context).to receive(:badge_format).with(content: source, options: options) { "Formatted Source" }
      end

      context "source - extended" do
        let(:badge_color) { "badge-warning" }

        it "expect to return source" do
          expect(presenter).to receive(:_extended?) { true }

          expect(subject).to eq "Formatted Source"
        end
      end

      context "source - not extended" do
        let(:badge_color) { "badge-info" }

        it { is_expected.to eq "Formatted Source" }
      end
    end
  end
end
