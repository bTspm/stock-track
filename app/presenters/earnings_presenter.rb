class EarningsPresenter
  include Btspm::Presenters::Presentable
  SURPRISES_COUNT = 4

  class Scalar < Btspm::Presenters::ScalarPresenter
    def actual
      data_object.actual&.round(StConstants::DEFAULT_DECIMALS_COUNT)
    end

    def category
      h.elements_in_single(["Q#{date.quarter}", date.year]).html_safe
    end

    def estimate
      data_object.estimate&.round(StConstants::DEFAULT_DECIMALS_COUNT)
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def chart_data
      surprises = sort_by(&:date).last(SURPRISES_COUNT)

      {
        actual: surprises.map(&:actual),
        categories: surprises.map(&:category),
        estimated: surprises.map(&:estimate)
      }.to_json
    end
  end
end
