class TimeSeriesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def formatted_chart_data
      [_formatted_date_time, close]
    end

    private

    def _formatted_date_time
      datetime.to_i * 1000
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    include Utils

    def chart_data(symbol)
      {
        stock_data: _ordered_by_datetime_asc.map(&:formatted_chart_data),
        symbol: symbol.upcase,
        time_line_buttons: _time_line_buttons,
      }.to_json
    end

    private

    def _ordered_by_datetime_asc
      @_ordered_by_datetime_asc ||= sort_by(&:datetime)
    end

    def _time_line_buttons
      [
        { type: "week", count: 1, text: "1w" },
        { type: "month", count: 1, text: "1m" },
        { type: "month", count: 3, text: "3m" },
        { type: "month", count: 6, text: "6m" },
        { type: "ytd", text: "YTD" },
        { type: "year", count: 1, text: "1y" },
        { type: "year", count: 5, text: "5y" },
        { type: "all", text: "All" }
      ]
    end
  end
end
