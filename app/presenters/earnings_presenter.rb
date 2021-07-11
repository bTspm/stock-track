class EarningsPresenter
  include Btspm::Presenters::Presentable
  SURPRISES_COUNT = 4

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    def actual
      h.st_number_to_currency data_object_actual&.round(StConstants::DEFAULT_DECIMALS_COUNT)
    end

    def category
      h.elements_in_single(["Q#{date.quarter}", date.year]).html_safe
    end

    def estimate
      h.st_number_to_currency data_object_estimate&.round(StConstants::DEFAULT_DECIMALS_COUNT)
    end

    def reported_quarter
      "Q#{date.quarter} - #{date.year}"
    end

    def surprise
      return "N/A" if data_object_surprise.blank?

      content = h.st_number_to_currency data_object_surprise&.round(StConstants::DEFAULT_DECIMALS_COUNT)
      h.content_color_by_value(content: content, value: data_object_surprise)
    end

    def surprise_percent
      return "N/A" if data_object_surprise_percent.blank?

      value = data_object_surprise_percent&.round(StConstants::DEFAULT_DECIMALS_COUNT)
      h.content_color_by_value(content: h.st_number_to_percentage(value), value: value)
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def chart_data
      earnings = sort_by(&:date).last(SURPRISES_COUNT)

      {
        actual: earnings.map(&:data_object_actual),
        categories: earnings.map(&:category),
        estimated: earnings.map(&:data_object_estimate)
      }
    end
  end
end
