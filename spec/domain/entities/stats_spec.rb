require "rails_helper"

describe Entities::Stats do
  it_behaves_like "Entities::BaseEntity#initialize"

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
     week_52_low: week_52_low,
    }
  end
  let(:beta) { double(:beta) }
  let(:dividend_yield) { double(:dividend_yield) }
  let(:float) { double(:float) }
  let(:market_cap) { double(:market_cap) }
  let(:moving_200_day_average) { double(:moving_200_day_average) }
  let(:moving_50_day_average) { double(:moving_50_day_average) }
  let(:next_dividend_date) { double(:next_dividend_date) }
  let(:next_earnings_date) { double(:next_earnings_date) }
  let(:pe_ratio) { double(:pe_ratio) }
  let(:shares_outstanding) { double(:shares_outstanding) }
  let(:ttm_dividend_rate) { double(:ttm_dividend_rate) }
  let(:ttm_eps) { double(:ttm_eps) }
  let(:volume_10_day_average) { double(:volume_10_day_average) }
  let(:volume_30_day_average) { double(:volume_30_day_average) }
  let(:week_52_high) { double(:week_52_high) }
  let(:week_52_low) { double(:week_52_low) }

  describe ".from_iex_response" do
    let(:args) do
      {
       beta: 1.1465479399284613,
       dividend_yield: 0.010009424458093661,
       float: 4329598232,
       market_cap: 1333719761400,
       moving_50_day_average: 273.11,
       moving_200_day_average: 263.21,
       next_dividend_date: converted_date,
       next_earnings_date: converted_date,
       pe_ratio: 23.92,
       shares_outstanding: 4334340000,
       ttm_dividend_rate: 3.08,
       ttm_eps: 12.8615,
       volume_10_day_average: 37676579.4,
       volume_30_day_average: 38930421.53,
       week_52_high: 327.85,
       week_52_low: 170.27
      }
    end
    let(:converted_date) { Date.new(2020, 0o7, 28) }
    let!(:response) { json_fixture("/api_responses/iex/stats.json") }

    subject { described_class.from_iex_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
