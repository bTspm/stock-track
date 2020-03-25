class EpsPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
  end

  class Enum < Btspm::Presenters::EnumPresenter
    def actuals
      _ordered_by_date_asc_last_4items.map(&:actual)
    end

    def dates
      _ordered_by_date_asc_last_4items.map(&:date)
    end

    def estimates
      _ordered_by_date_asc_last_4items.map(&:estimate)
    end

    private

    def _ordered_by_date_asc
      @_ordered_by_date_asc ||= sort_by(&:date)
    end

    def _ordered_by_date_asc_last_4items
      @_ordered_by_date_asc_last_4items ||= _ordered_by_date_asc.last(4)
    end
  end
end
