FactoryBot.define do
  factory :entity_stats, class: Entities::Stats do
    args do
      {
        beta: 1.23,
        dividend_yield: 5.89,
        float: 200_000,
        market_cap: 500_000,
        moving_200_day_average: 200,
        moving_50_day_average: 50,
        next_dividend_date: Date.new(2020, 01, 01),
        next_earnings_date: Date.new(2020, 05, 01),
        pe_ratio: 1.56,
        shares_outstanding: 890_000,
        ttm_dividend_rate: 3.45,
        ttm_eps: 6.78,
        volume_10_day_average: 10,
        volume_30_day_average: 30,
        week_52_high: 5_000,
        week_52_low: 1_000
      }
    end

    initialize_with { new(args) }
  end
end
