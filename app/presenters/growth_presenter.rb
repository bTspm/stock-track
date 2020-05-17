class GrowthPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def chart_data
      {
       data: growth_details.values.reverse.map(&:to_i),
       xaxis_titles: growth_details.keys.reverse,
      }.to_json
    end

    def growth_details
      @growth_details ||= {
       '5D': format_percentage(day_5),
       '1M': format_percentage(month_1),
       '3M': format_percentage(month_3),
       '6M': format_percentage(month_6),
       'YTD': format_percentage(ytd),
       '1Y': format_percentage(year_1),
       '5Y': format_percentage(year_5),
      }
    end
  end
end
