class RecommendationTrendsPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def chart_data
      {categories: _categories, series: _series}
    end

    private

    def _buy_series
      {
        name: "Buy",
        data: _data(:buy)
      }
    end

    def _categories
      _ordered_by_date_asc_last_5items.map { |item| "#{item.date.strftime("%b")}<br>#{item.date.year}" }
    end

    def _data(type)
      _ordered_by_date_asc_last_5items.map(&type)
    end

    def _hold_series
      {
        name: "Hold",
        data: _data(:hold)
      }
    end

    def _ordered_by_date_asc
      @_ordered_by_date_asc ||= sort_by(&:date)
    end

    def _ordered_by_date_asc_last_5items
      @_ordered_by_date_asc_last_4items ||= _ordered_by_date_asc.last(5)
    end

    def _sell_series
      {
        name: "Sell",
        data: _data(:sell)
      }
    end

    def _series
      [
        _strong_buy_series,
        _buy_series,
        _hold_series,
        _sell_series,
        _strong_sell_series
      ].compact
    end

    def _strong_buy_series
      {
        name: "Strong Buy",
        data: _data(:strong_buy)
      }
    end

    def _strong_sell_series
      {
        name: "Strong Sell",
        data: _data(:strong_sell)
      }
    end
  end
end
