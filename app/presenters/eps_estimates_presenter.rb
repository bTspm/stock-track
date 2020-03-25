class EpsEstimatesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def dates
      _ordered_by_date_asc.map(&:date)
    end

    def estimates
      _ordered_by_date_asc.map(&:average)
    end

    private

    def _ordered_by_date_asc
      @_ordered_by_date_asc ||= sort_by(&:date)
    end
  end
end
