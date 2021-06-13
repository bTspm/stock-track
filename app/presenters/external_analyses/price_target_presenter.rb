module ExternalAnalyses
  class PriceTargetPresenter
    include Btspm::Presenters::Presentable

    CHART_CATEGORIES = ["Low", "Average", "High"]

    class Scalar < Btspm::Presenters::ScalarPresenter
      include Utils

      def chart_data
        [data_object_low, data_object_average, data_object_high]
      end

      def low
        h.st_number_to_currency data_object_low
      end

      def average
        h.st_number_to_currency data_object_average
      end

      def high
        h.st_number_to_currency data_object_high
      end
    end
  end
end
