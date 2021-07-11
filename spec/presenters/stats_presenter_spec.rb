require "rails_helper"

describe StatsPresenter do
  describe ".scalar" do
    let(:stats) { build :entity_stats }
    subject(:presenter) { described_class::Scalar.new(stats, view_context) }

    describe "#beta" do
      subject { presenter.beta }

      context "without beta" do
        let(:stats) { build :entity_stats, beta: nil }

        it { is_expected.to eq "N/A" }
      end

      context "with beta" do
        it { is_expected.to eq 1.23 }
      end
    end

    describe "#dividend_rate_and_yield" do
      subject { presenter.dividend_rate_and_yield }

      context "without dividend_rate and dividend_yield" do
        let(:stats) { build :entity_stats, ttm_dividend_rate: nil, dividend_yield: nil }

        it { is_expected.to eq "N/A" }
      end

      context "without dividend_rate and with dividend_yield" do
        let(:stats) { build :entity_stats, ttm_dividend_rate: nil }

        it "expect to return formatted date/yield and and N/A for rate" do
          expect(subject).to eq "N/A"
        end
      end

      context "without dividend_yield and with dividend_rate" do
        let(:stats) { build :entity_stats, dividend_yield: nil }

        it "expect to return formatted rate/date and N/A for yield" do
          expect(subject).to eq "N/A"
        end
      end

      context "with date dividend_rate and dividend_yield" do
        it "expect to return formatted rate/yield" do
          expect(view_context).to receive(:st_number_to_percentage).with(5.89) { "Yield" }
          expect(view_context).to receive(:st_number_to_currency).with(3.45) { "Rate" }

          expect(subject).to eq "Rate (Yield)"
        end
      end
    end

    describe "#dividend_yield" do
      subject { presenter.dividend_yield }

      context "without dividend_yield" do
        let(:stats) { build :entity_stats, dividend_yield: nil }

        it { is_expected.to eq "N/A" }
      end

      context "with dividend_yield" do
        it { is_expected.to eq "5.89%" }
      end
    end

    describe "#ttm_eps" do
      subject { presenter.ttm_eps }

      it "expect to call st_number_to_currency with eps" do
        expect(view_context).to receive(:st_number_to_currency).with(6.78, { precision: 3 }) { "EPS" }
        expect(
          view_context
        ).to receive(:content_color_by_value).with(content: "EPS", value: 6.78) { "Formatted Content" }

        expect(subject).to eq "Formatted Content"
      end
    end

    describe "#float" do
      subject { presenter.float }

      it "expect to call st_number_to_human with float" do
        expect(view_context).to receive(:st_number_to_human).with(200_000, { precision: 10 }) { "Float" }

        expect(subject).to eq "Float"
      end
    end

    describe "#market_cap" do
      subject { presenter.market_cap }

      it "expect to call st_number_to_currency, st_number_to_human with market_cap" do
        expect(view_context).to receive(:st_number_to_human).with(500_000, { precision: 3 }) { "Market Cap" }
        expect(view_context).to receive(:st_number_to_currency).with("Market Cap") { "MCap" }

        expect(subject).to eq "MCap"
      end
    end

    describe "#pe_ratio" do
      subject { presenter.pe_ratio }

      context "without pe_ratio" do
        let(:stats) { build :entity_stats, pe_ratio: nil }

        it { is_expected.to eq "N/A" }
      end

      context "with pe_ratio" do
        it { is_expected.to eq 1.56 }
      end
    end

    describe "#shares_outstanding" do
      subject { presenter.shares_outstanding }

      it "expect to call st_number_to_human with shares_outstanding" do
        expect(view_context).to receive(:st_number_to_human).with(890_000, { precision: 3 }) { "Shared O/S" }

        expect(subject).to eq "Shared O/S"
      end
    end

    describe "#volume_30_day_average" do
      subject { presenter.volume_30_day_average }

      it "expect to call st_number_to_human with volume_30_day_average" do
        expect(view_context).to receive(:st_number_to_human).with(30, { precision: 5 }) { "Vol Avg" }

        expect(subject).to eq "Vol Avg"
      end
    end

    describe "#week_52_range" do
      subject { presenter.week_52_range }

      it "expect to call st_number_to_human with low and high values" do
        expect(view_context).to receive(:st_number_to_currency).with(1_000) { "Low" }
        expect(view_context).to receive(:st_number_to_currency).with(5_000) { "High" }

        expect(subject).to eq "Low - High"
      end
    end
  end
end
