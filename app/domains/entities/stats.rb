module Entities
  class Stats < BaseEntity
    ATTRIBUTES = %i[beta
                    dividend_yield
                    float
                    market_cap
                    moving_50_day_average
                    moving_200_day_average
                    next_dividend_date
                    next_earnings_date
                    pe_ratio
                    shares_outstanding
                    ttm_dividend_rate
                    ttm_eps
                    volume_10_day_average
                    volume_30_day_average
                    week_52_high
                    week_52_low].freeze

    attr_reader *ATTRIBUTES

    def self.from_iex_response(response)
      args = {
       beta: response[:beta],
       dividend_yield: response[:dividendYield],
       float: response[:float],
       market_cap: response[:marketcap],
       moving_50_day_average: response[:day50MovingAvg],
       moving_200_day_average: response[:day200MovingAvg],
       next_dividend_date: response[:nextDividendDate]&.to_date,
       next_earnings_date: response[:nextEarningsDate]&.to_date,
       pe_ratio: response[:peRatio],
       shares_outstanding: response[:sharesOutstanding],
       ttm_dividend_rate: response[:ttmDividendRate],
       ttm_eps: response[:ttmEPS],
       volume_10_day_average: response[:avg10Volume],
       volume_30_day_average: response[:avg30Volume],
       week_52_high: response[:week52high],
       week_52_low: response[:week52low],
      }

      new(args)
    end
  end
end
