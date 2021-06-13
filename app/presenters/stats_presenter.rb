class StatsPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def beta
      return "N/A" if data_object_beta.blank?

      data_object_beta.round(StConstants::DEFAULT_DECIMALS_COUNT)
    end

    def dividend_rate_and_yield
      return "N/A" if ttm_dividend_rate.blank? || data_object_dividend_yield.blank?

      div_yield = h.st_number_to_percentage dividend_yield
      rate = h.st_number_to_currency ttm_dividend_rate&.round(StConstants::DEFAULT_DECIMALS_COUNT)
      "#{rate} (#{div_yield})"
    end

    def dividend_yield
      return "N/A" if data_object_dividend_yield.blank?

      data_object_dividend_yield&.round(StConstants::DEFAULT_DECIMALS_COUNT)
    end

    def eps
      h.st_number_to_currency(ttm_eps, precision: 3)
    end

    def float
      h.st_number_to_human data_object_float, precision: 10
    end

    def market_cap
      h.st_number_to_currency h.st_number_to_human data_object_market_cap, precision: 3
    end

    def pe_ratio
      return "N/A" if data_object_pe_ratio.blank?

      data_object_pe_ratio&.round(StConstants::DEFAULT_DECIMALS_COUNT)
    end

    def shares_outstanding
      h.st_number_to_human data_object_shares_outstanding, precision: 3
    end

    def volume_30_day_average
      h.st_number_to_human data_object_volume_30_day_average, precision: 5
    end

    def week_52_range
      "#{h.st_number_to_currency(data_object_week_52_low)} - #{h.st_number_to_currency(data_object_week_52_high)}".html_safe
    end
  end
end
