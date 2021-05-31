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

    def formatted_ytd
      return "N/A" if ytd.blank?

      content = h.st_number_to_percentage ytd&.round(StConstants::DEFAULT_DECIMALS_COUNT)
      h.content_color_by_value(content: content, value: ytd)
    end

    private

    def _growth_details_ordered_by_time_desc
      @_growth_details_ordered_by_time_desc ||= {
        '5Y': year_5&.round(StConstants::DEFAULT_DECIMALS_COUNT),
        '1Y': year_1&.round(StConstants::DEFAULT_DECIMALS_COUNT),
        'YTD': ytd&.round(StConstants::DEFAULT_DECIMALS_COUNT),
        '6M': month_6&.round(StConstants::DEFAULT_DECIMALS_COUNT),
        '3M': month_3&.round(StConstants::DEFAULT_DECIMALS_COUNT),
        '1M': month_1&.round(StConstants::DEFAULT_DECIMALS_COUNT),
        '5D': day_5&.round(StConstants::DEFAULT_DECIMALS_COUNT)
      }
    end
  end
end
