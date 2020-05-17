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

    def dividend_rate_and_yield_with_next_date
      return "N/A" if _no_dividends?

      dividend_date_content = h.content_tag :div, "next (#{next_dividend_date})", class: "small"
      ("#{dividend_rate} / #{dividend_yield}" + dividend_date_content).html_safe
    end

    def float
      value_or_na h.number_to_human data_object.float, precesion: 10
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

    def shares_outstanding
      value_or_na h.number_to_human data_object.shares_outstanding, precision: 3
    end

    def ttm_eps_with_next_date
      return "N/A" if data_object.ttm_eps.blank?

      eps_date_content = h.content_tag :div, "next (#{next_earnings_date})", class: "small"
      (value_or_na(h.number_to_human data_object.ttm_eps) +  eps_date_content).html_safe
    end

    def volume_average
      return "N/A" if volume_10_day_average.blank? && volume_30_day_average.blank?

      "#{h.number_to_human volume_10_day_average} / #{h.number_to_human volume_30_day_average}"
    end

    def moving_average
      return "N/A" if moving_50_day_average.blank? && moving_200_day_average.blank?

      "#{h.number_to_human moving_50_day_average} / #{h.number_to_human moving_200_day_average}"
    end

    def week_52_range
      return "N/A" if week_52_low.blank? && week_52_high.blank?

      "#{week_52_low} - #{week_52_high}".html_safe
    end

    def week_52_high
      h.positive_content(h.number_with_delimiter(data_object.week_52_high))
    end

    def week_52_low
      h.negative_content(h.number_with_delimiter(data_object.week_52_low))
    end

    private

    def _no_dividends?
      data_object.ttm_dividend_rate.blank? && data_object.dividend_yield.blank?
    end
  end
end
