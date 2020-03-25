  class Stats

    attr_reader :avg_10_volume,
                :avg_30_volume,
                :beta,
                :company_name,
                :day_200_moving_avg,
                :day_30_change_percent,
                :day_50_moving_avg,
                :day_5_change_percent,
                :dividend_yield,
                :employees,
                :ex_dividend_date,
                :float,
                :market_cap,
                :max_change_percent,
                :month_1_change_percent,
                :month_3_change_percent,
                :month_6_change_percent,
                :next_dividend_date,
                :next_earnings_date,
                :pe_ratio,
                :shares_outstanding,
                :ttm_dividend_rate,
                :ttm_eps,
                :week_52_change_pct,
                :week_52_high,
                :week_52_low,
                :year_1_change_percent,
                :year_2_change_percent,
                :year_5_change_percent,
                :ytd_change_percent

    def initialize(response = {})
      @avg_10_volume = response[:avg10Volume]
      @avg_30_volume = response[:avg30Volume]
      @beta = response[:beta]
      @company_name = response[:companyName]
      @day_200_moving_avg = response[:day200MovingAvg]
      @day_30_change_percent = response[:day30ChangePercent]
      @day_50_moving_avg = response[:day50MovingAvg]
      @day_5_change_percent = response[:day5ChangePercent]
      @dividend_yield = response[:dividendYield]
      @employees = response[:employees]
      @ex_dividend_date = response[:exDividendDate]&.to_date
      @float = response[:float]
      @market_cap = response[:marketcap]
      @max_change_percent = response[:maxChangePercent]
      @month_1_change_percent = response[:month1ChangePercent]
      @month_3_change_percent = response[:month3ChangePercent]
      @month_6_change_percent = response[:month6ChangePercent]
      @next_dividend_date = response[:nextDividendDate]&.to_date
      @next_earnings_date = response[:nextEarningsDate]&.to_date
      @pe_ratio = response[:peRatio]
      @shares_outstanding = response[:sharesOutstanding]
      @ttm_dividend_rate = response[:ttmDividendRate]
      @ttm_eps = response[:ttmEPS]
      @week_52_change_pct = response[:week52change]
      @week_52_high = response[:week52high]
      @week_52_low = response[:week52low]
      @year_1_change_percent = response[:year1ChangePercent]
      @year_2_change_percent = response[:year2ChangePercent]
      @year_5_change_percent = response[:year5ChangePercent]
      @ytd_change_percent = response[:ytdChangePercent]
    end
  end
