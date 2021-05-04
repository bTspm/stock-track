module ExternalAnalyses
  class AnalysesPresenter
    PRICE_TARGET_CHART_CATEGORIES = ["Low", "Average", "High"]

    include Btspm::Presenters::Presentable

    class Scalar < Btspm::Presenters::ScalarPresenter
      include Utils

      def chart_data
        return if price_target.blank?

        {
          name: formatted_source,
          data: [price_target.low, price_target.average, price_target.high]
        }
      end

      def formatted_original_rating
        value_or_na(original_rating)
      end

      def formatted_source
        source.gsub("_", " ").titleize
      end
    end

    class Enum < Btspm::Presenters::EnumPresenter
      def custom_analyses_sorted_by_source_asc
        reject { |analysis| analysis.custom.blank? }.sort_by(&:source)
      end

      def ordered_by_source_asc_with_no_ratings_last
        sort_by { |analysis| [(analysis.original_rating.blank? ? 1 : 0), analysis.source] }
      end

      def price_targets_chart_data
        map(&:chart_data).compact.to_json
      end
    end
  end
end
