class RecommendationTrendsPresenter
  include Btspm::Presenters::Presentable
  MONTH_DATE_FORMAT = "%b"
  TREND_COUNT = 5

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def formatted_month_with_year
      "#{_date_with_month}<br>#{date.year}"
    end

    private

    def _date_with_month
      readable_date(date: date, format: MONTH_DATE_FORMAT)
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def chart_data
      {categories: _categories, series: _ordered_series}.to_json
    end

    private

    def _buy_series
      {data: _ordered_by_date_asc.map(&:buy), name: "Buy"}
    end

    def _categories
      _ordered_by_date_asc.map(&:formatted_month_with_year)
    end

    def _hold_series
      {data: _ordered_by_date_asc.map(&:hold), name: "Hold"}
    end

    def _ordered_by_date_asc
      @_ordered_by_date_asc ||= sort_by(&:date).last(TREND_COUNT)
    end

    def _ordered_series
      [
       _strong_buy_series,
       _buy_series,
       _hold_series,
       _sell_series,
       _strong_sell_series
      ].compact
    end

    def _sell_series
      {data: _ordered_by_date_asc.map(&:sell), name: "Sell"}
    end

    def _strong_buy_series
      {data: _ordered_by_date_asc.map(&:strong_buy), name: "Strong Buy"}
    end

    def _strong_sell_series
      {data: _ordered_by_date_asc.map(&:strong_sell), name: "Strong Sell"}
    end
  end
end
