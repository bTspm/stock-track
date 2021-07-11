class TimeSeriesPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    def chart_data
      [(datetime.to_i * 1000), close]
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    include Utils

    def chart_data
      sort_by(&:datetime).map(&:chart_data)
    end
  end
end
