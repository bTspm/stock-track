module Entities
  module ExternalAnalyses
    class Analysis < BaseEntity
      ATTRIBUTES = [
        :analysts_count,
        :custom,
        :original_rating,
        :price_target,
        :rating_rank,
        :source,
        :url
      ]

      BAR_CHART = "bar_chart"
      TIP_RANKS = "tip_ranks"
      THE_STREET = "the_street"
      WE_BULL = "we_bull"
      ZACKS = "zacks"

      STRONG_BUYS_RANK = 1
      BUYS_RANK = 2
      HOLDS_RANK = 3
      SELLS_RANK = 4
      STRONG_SELLS_RANK = 5

      attr_accessor *ATTRIBUTES, :rating_rank

      class << self
        def from_data_hash(analysis)
          args = ATTRIBUTES.each_with_object(Hash.new) do |attribute, hash|
            value = analysis[attribute]
            hash[attribute] = value.present? && value.is_a?(Hash) ? OpenStruct.new(value) : value
          end

          new(args)
        end

        def null_object_with_source(source)
          new({ source: source })
        end
      end

      def initialize(args = {})
        super
        @rating_rank ||= _rating_rank
      end

      def basic?
        custom.blank? && price_target.blank?
      end

      private

      def _rating_rank
        ratings = Entities::ExternalAnalyses::RatingMappings::SOURCE_AND_RATING_MAPPING[source]
        return nil if ratings.blank?

        case original_rating
        when *ratings[:strong_buy]
          STRONG_BUYS_RANK
        when *ratings[:buy]
          BUYS_RANK
        when *ratings[:hold]
          HOLDS_RANK
        when *ratings[:sell]
          SELLS_RANK
        when *ratings[:strong_sell]
          STRONG_SELLS_RANK
        else
          nil
        end
      end
    end
  end
end
