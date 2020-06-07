class GrowthPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def chart_data
      {
       data: _growth_details_ordered_by_time_desc.values,
       xaxis_titles: _growth_details_ordered_by_time_desc.keys
      }.to_json
    end

    private

    def _growth_details_ordered_by_time_desc
      @_growth_details_ordered_by_time_desc ||= {
       '5Y': percentage_value(year_5),
       '1Y': percentage_value(year_1),
       'YTD': percentage_value(ytd),
       '6M': percentage_value(month_6),
       '3M': percentage_value(month_3),
       '1M': percentage_value(month_1),
       '5D': percentage_value(day_5)
      }
    end
  end
end
