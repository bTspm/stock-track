module Entities
  class ExternalAnalysis
    STRONG_BUY = :strong_buy
    BUY = :buy
    HOLD = :hold
    SELL = :sell
    STRONG_SELL = :strong_sell

    class << self
      # @param [String] json json blob saved in Company
      def from_json(json)
        data = JSON.parse(json, symbolize_names: true)
        analyses = data[:analyses].map { |analysis| Entities::ExternalAnalyses::Analysis.from_data_hash(analysis) }
        new(analyses: analyses, refreshed_at: data[:refreshed_at].to_datetime)
      end

      def null_object
        new(analyses: [], refreshed_at: DateTime.now)
      end
    end

    attr_accessor :analyses, :refreshed_at

    # @param [Array<Entities::ExternalAnalyses::Analysis>] analyses a collection of analyses
    # @param [DateTime] refreshed_at datetime when the analysis was updated
    def initialize(analyses:, refreshed_at:)
      @analyses = analyses
      @refreshed_at = refreshed_at
    end

    def average_rating_rank
      return @average_rating_rank if defined? @average_rating_rank

      rating_ranks = analyses.map(&:rating_rank).compact
      @average_rating_rank ||= rating_ranks.blank? ? nil : rating_ranks.sum / rating_ranks.count.to_f
    end

    def average_rating_signal
      return nil if average_rating_rank.blank?

      case average_rating_rank
      when 1..1.5
        STRONG_BUY
      when 1.51..2.25
        BUY
      when 2.26..3.25
        HOLD
      when 3.26..4.25
        SELL
      when 4.26..5.0
        STRONG_SELL
      else
        :unknown
      end
    end

    def data_available?
      analyses.any?
    end

    def total_analysts
      return nil unless data_available?

      analyses.map { |analyst| analyst.analysts_count || 0 }.inject(:+)
    end
  end
end
