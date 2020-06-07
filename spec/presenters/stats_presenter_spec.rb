require "rails_helper"

describe StatsPresenter do
  describe ".scalar" do
    let(:args) do
      {
        beta: beta,
        dividend_yield: dividend_yield,
        float: float,
        market_cap: market_cap,
        moving_200_day_average: moving_200_day_average,
        moving_50_day_average: moving_50_day_average,
        next_dividend_date: next_dividend_date,
        next_earnings_date: next_earnings_date,
        pe_ratio: pe_ratio,
        shares_outstanding: shares_outstanding,
        ttm_dividend_rate: ttm_dividend_rate,
        ttm_eps: ttm_eps,
        volume_10_day_average: volume_10_day_average,
        volume_30_day_average: volume_30_day_average,
        week_52_high: week_52_high,
        week_52_low: week_52_low
      }
    end
    let(:beta) { 100.3456 }
    let(:dividend_yield) { 0.42345 }
    let(:float) { 200_000 }
    let(:object) { double(:object, args) }
    let(:market_cap) { 300_000 }
    let(:moving_200_day_average) { 377_000 }
    let(:moving_50_day_average) { 277_000 }
    let(:next_dividend_date) { Date.new(2020, 0o5, 0o1) }
    let(:next_earnings_date) { Date.new(2020, 0o6, 0o1) }
    let(:pe_ratio) { double(:pe_ratio) }
    let(:shares_outstanding) { 2_000 }
    let(:ttm_dividend_rate) { 500.2345 }
    let(:ttm_eps) { 99.098 }
    let(:volume_10_day_average) { 177_000 }
    let(:volume_30_day_average) { 298_000 }
    let(:week_52_high) { 577_000 }
    let(:week_52_low) { 677_000 }

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#beta" do
      subject { presenter.beta }

      context "without beta" do
        let(:beta) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "with beta" do
        it { is_expected.to eq 100.346 }
      end
    end

    describe "#dividend_rate_and_yield_with_next_date" do
      subject { presenter.dividend_rate_and_yield_with_next_date }

      context "without dividend_rate and dividend_yield" do
        let(:ttm_dividend_rate) { nil }
        let(:dividend_yield) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "without dividend_rate and with dividend_yield, date" do
        let(:ttm_dividend_rate) { nil }

        it "expect to return formatted date/yield and and N/A for rate" do
          expect(subject).to include "next (May 01, 2020)"
          expect(subject).to include "42.35%"
          expect(subject).to include "N/A"
        end
      end

      context "without dividend_yield and with dividend_rate, date" do
        let(:dividend_yield) { nil }

        it "expect to return formatted rate/date and N/A for yield" do
          expect(subject).to include "500.235"
          expect(subject).to include "next (May 01, 2020)"
          expect(subject).to include "N/A"
        end
      end

      context "without date and with dividend_rate, dividend_yield" do
        let(:next_dividend_date) { nil }

        it "expect to return formatted rate/yield and N/A for date" do
          expect(subject).to include "500.235"
          expect(subject).to include "42.35%"
          expect(subject).to include "N/A"
        end
      end

      context "with date dividend_rate and dividend_yield" do
        it "expect to return formatted rate/yield and date" do
          expect(subject).to include "500.235"
          expect(subject).to include "42.35%"
          expect(subject).to include "next (May 01, 2020)"
        end
      end
    end

    describe "#float" do
      subject { presenter.float }

      context "without float" do
        let(:float) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "with float" do
        it { is_expected.to eq "200 Thousand" }
      end
    end

    describe "#market_cap" do
      subject { presenter.market_cap }

      context "without market_cap" do
        let(:market_cap) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "with market_cap" do
        it { is_expected.to eq "300 Thousand" }
      end
    end

    describe "#moving_average" do
      subject { presenter.moving_average }

      context "without 50day and 200day moving average" do
        let(:moving_200_day_average) { nil }
        let(:moving_50_day_average) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "without 50day and with 200day moving average" do
        let(:moving_50_day_average) { nil }

        it { is_expected.to eq "N/A / 377 Thousand" }
      end

      context "without 200day and with 50day moving average" do
        let(:moving_200_day_average) { nil }

        it { is_expected.to eq "277 Thousand / N/A" }
      end

      context "with 50day and with 200day moving average" do
        it { is_expected.to eq "277 Thousand / 377 Thousand" }
      end
    end

    describe "#pe_ratio" do
      subject { presenter.pe_ratio }

      context "without pe_ratio" do
        let(:pe_ratio) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "with pe_ratio" do
        it { is_expected.to eq pe_ratio }
      end
    end

    describe "#shares_outstanding" do
      subject { presenter.shares_outstanding }

      context "without shares_outstanding" do
        let(:shares_outstanding) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "with shares_outstanding" do
        it { is_expected.to eq "2 Thousand" }
      end
    end

    describe "#ttm_eps_with_next_date" do
      subject { presenter.ttm_eps_with_next_date }

      context "without ttm_eps" do
        let(:ttm_eps) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "without date and with ttm_eps" do
        let(:next_earnings_date) { nil }

        it "expect to return formatted ttm_eps and N/A for date" do
          expect(subject).to include "99.1"
          expect(subject).to include "N/A"
        end
      end

      context "with date and ttm_eps" do
        it "expect to return formatted ttm_eps and date" do
          expect(subject).to include "99.1"
          expect(subject).to include "next (Jun 01, 2020)"
        end
      end
    end

    describe "#volume_average" do
      subject { presenter.volume_average }

      context "without 10day and 30day volume average" do
        let(:volume_10_day_average) { nil }
        let(:volume_30_day_average) { nil }

        it { is_expected.to eq "N/A" }
      end

      context "without 10day and with 30day volume average" do
        let(:volume_10_day_average) { nil }

        it { is_expected.to eq "N/A / 298 Thousand" }
      end

      context "without 30day and 10days volume average" do
        let(:volume_30_day_average) { nil }

        it { is_expected.to eq "177 Thousand / N/A" }
      end

      context "with 10day and with 30day volume average" do
        it { is_expected.to eq "177 Thousand / 298 Thousand" }
      end
    end

    describe "#week_52_range" do
      subject { presenter.week_52_range }

      context "without week52low and week52high" do
        let(:week_52_high) { nil }
        let(:week_52_low) { nil }

        it "expect not to call positive_content or negative_content" do
          expect(view_context).not_to receive(:positive_content)
          expect(view_context).not_to receive(:negative_content)

          expect(subject).to eq "N/A"
        end
      end

      context "without week52low and with week52high" do
        let(:week_52_low) { nil }

        it "expect to include formatted high value and N/A for low" do
          expect(view_context).to receive(:positive_content).with("577,000") { "High" }
          expect(view_context).not_to receive(:negative_content)

          expect(subject).to eq "N/A - High"
        end
      end

      context "with week52low and without week52high" do
        let(:week_52_high) { nil }

        it "expect to include formatted low value and N/A for high" do
          expect(view_context).to receive(:negative_content).with("677,000") { "Low" }
          expect(view_context).not_to receive(:positive_content)

          expect(subject).to eq "Low - N/A"
        end
      end

      context "with week52low and week52high" do
        it "expect to include formatted low value and high value" do
          expect(view_context).to receive(:negative_content).with("677,000") { "Low" }
          expect(view_context).to receive(:positive_content).with("577,000") { "High" }

          expect(subject).to eq "Low - High"
        end
      end
    end
  end
end
