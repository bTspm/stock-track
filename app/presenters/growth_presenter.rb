class GrowthPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def chart_data
      {
        data: _growth_details_ordered_by_time_desc.values,
        xaxis_titles: _growth_details_ordered_by_time_desc.keys
      }
    end

    def day_5
      _format_pct(data_object_day_5)
    end

    def month_1
      _format_pct(data_object_month_1)
    end

    def month_3
      _format_pct(data_object_month_3)
    end

    def month_6
      _format_pct(data_object_month_6)
    end

    def ytd
      _format_pct(data_object_ytd)
    end

    def year_1
      _format_pct(data_object_year_1)
    end

    def year_5
      _format_pct(data_object_year_5)
    end

    def max
      _format_pct(data_object_max)
    end

    private

    def _format_pct(pct)
      return "N/A" if pct.blank?

      h.content_color_by_value(content: h.st_number_to_percentage(pct), value: pct)
    end

    def _growth_details_ordered_by_time_desc
      @_growth_details_ordered_by_time_desc ||= {
        "5Y" => data_object_year_5&.round(StConstants::DEFAULT_DECIMALS_COUNT),
        "1Y" => data_object_year_1&.round(StConstants::DEFAULT_DECIMALS_COUNT),
        "YTD" => data_object_ytd&.round(StConstants::DEFAULT_DECIMALS_COUNT),
        "6M" => data_object_month_6&.round(StConstants::DEFAULT_DECIMALS_COUNT),
        "3M" => data_object_month_3&.round(StConstants::DEFAULT_DECIMALS_COUNT),
        "1M" => data_object_month_1&.round(StConstants::DEFAULT_DECIMALS_COUNT),
        "5D" => data_object_day_5&.round(StConstants::DEFAULT_DECIMALS_COUNT)
      }
    end
  end
end
