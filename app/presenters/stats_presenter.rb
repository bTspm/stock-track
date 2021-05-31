class StatsPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def beta
      return "N/A" if data_object.beta.blank?

      data_object.beta.round(StConstants::DEFAULT_DECIMALS_COUNT)
    end

    def dividend_rate_and_yield_with_next_date
      return "N/A" if _no_dividends?

      dividend_date_content = h.content_tag :div, "next (#{_next_dividend_date})", class: "small"
      ("#{_dividend_rate} / #{dividend_yield}  #{dividend_date_content}").html_safe
    end

    def dividend_yield
      return "N/A" if data_object.dividend_yield.blank?

      h.st_number_to_percentage(data_object.dividend_yield * 100)
    end

    def float
      h.st_number_to_human data_object.float, precision: 10
    end

    def market_cap
      h.st_number_to_human data_object.market_cap, precision: 3
    end

    def moving_average
      return "N/A" if _no_moving_average?

      "#{_moving_50_day_average} / #{_moving_200_day_average}"
    end

    def pe_ratio
      return "N/A" if data_object.pe_ratio.blank?

      data_object.pe_ratio&.round(StConstants::DEFAULT_DECIMALS_COUNT)
    end

    def shares_outstanding
      h.st_number_to_human data_object.shares_outstanding, precision: 3
    end

    def ttm_eps_with_next_date
      return "N/A" if ttm_eps.blank?

      eps_date_content = h.content_tag :div, "next (#{_next_earnings_date})", class: "small"
      ("#{h.st_number_to_human(ttm_eps, precision: 3)}  #{eps_date_content}").html_safe
    end

    def volume_average
      return "N/A" if _no_volume_average?

      "#{_volume_10_day_average} / #{_volume_30_day_average}"
    end

    def week_52_range
      return "N/A" if _no_week_52_range?

      "#{_week_52_low} - #{_week_52_high}".html_safe
    end

    private

    def _dividend_rate
      value_or_na ttm_dividend_rate&.round(StConstants::DEFAULT_DECIMALS_COUNT)
    end

    def _moving_200_day_average
      h.st_number_to_human moving_200_day_average, precision: 5
    end

    def _moving_50_day_average
      h.st_number_to_human moving_50_day_average, precision: 5
    end

    def _next_dividend_date
      h.readable_date(date: next_dividend_date)
    end

    def _next_earnings_date
      h.readable_date(date: next_earnings_date)
    end

    def _no_dividends?
      ttm_dividend_rate.blank? && data_object.dividend_yield.blank?
    end

    def _no_moving_average?
      moving_50_day_average.blank? && moving_200_day_average.blank?
    end

    def _no_volume_average?
      volume_10_day_average.blank? && volume_30_day_average.blank?
    end

    def _no_week_52_range?
      week_52_low.blank? && week_52_high.blank?
    end

    def _volume_10_day_average
      h.st_number_to_human volume_10_day_average, precision: 5
    end

    def _volume_30_day_average
      h.st_number_to_human volume_30_day_average, precision: 5
    end

    def _week_52_high
      return "N/A" if week_52_high.blank?

      h.positive_content(h.st_number_with_delimiter(week_52_high))
    end

    def _week_52_low
      return "N/A" if week_52_low.blank?

      h.negative_content(h.st_number_with_delimiter(week_52_low))
    end
  end
end
