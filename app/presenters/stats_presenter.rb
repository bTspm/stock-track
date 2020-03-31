class StatsPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def beta
      return "N/A" if data_object.beta.blank?
      data_object.beta.round(3)
    end

    def dividend_rate
      value_or_na ttm_dividend_rate&.round(3)
    end

    def dividend_yield
      format_percentage data_object.dividend_yield
    end

    def dividend_rate_and_yield
      return "N/A" if data_object.ttm_dividend_rate.blank? && data_object.dividend_yield.blank?

      "#{dividend_rate} / #{dividend_yield}"
    end

    def ex_dividend_date
      readable_date data_object.ex_dividend_date
    end

    def float
      value_or_na h.number_to_human data_object.float, precesion: 10
    end

    def growth_details
      @growth_details ||= {
       '5D': format_percentage(day_5_change_percent),
       '1M': format_percentage(month_1_change_percent),
       '3M': format_percentage(month_3_change_percent),
       '6M': format_percentage(month_6_change_percent),
       'YTD': format_percentage(ytd_change_percent),
       '1Y': format_percentage(year_1_change_percent),
       '5Y': format_percentage(year_5_change_percent),
      }
    end

    def growth_chart_data
      {
       data: growth_details.values.reverse.map(&:to_i),
       xaxis_titles: growth_details.keys.reverse,
      }.to_json
    end

    def market_cap
      value_or_na h.number_to_human data_object.market_cap, precision: 3
    end

    def next_dividend_date
      readable_date data_object.next_dividend_date
    end

    def next_earnings_date
      readable_date data_object.next_earnings_date
    end

    def pe_ratio
      value_or_na data_object.pe_ratio
    end

    def ttm_eps
      value_or_na h.number_to_human data_object.ttm_eps
    end
  end
end
