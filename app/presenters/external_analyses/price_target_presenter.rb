module ExternalAnalyses
  class PriceTargetPresenter
    include Btspm::Presenters::Presentable

    CHART_CATEGORIES = ["Low", "Average", "High"]

    class Scalar < Btspm::Presenters::ScalarPresenter
      def chart_data
        [data_object.low, data_object.average, data_object.high]
      end

      def low
        h.st_number_with_delimiter data_object.low
      end

      def average
        h.st_number_with_delimiter data_object.average
      end

      def high
        h.st_number_with_delimiter data_object.high
      end
    end
  end
end
