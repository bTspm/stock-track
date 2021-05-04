module Entities
  class ExternalAnalysis
    class << self
      # @param [String] json json blob saved in Company
      def from_json(json)
        data = JSON.parse(json, symbolize_names: true)
        analyses = data[:analyses].map { |analysis| Entities::ExternalAnalyses::Analysis.from_data_hash(analysis) }
        new(analyses: analyses, refreshed_at: data[:refreshed_at].to_datetime)
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
      rating_ranks = analyses.map(&:rating_rank).compact
      return nil if rating_ranks.blank?

      rating_ranks.sum / rating_ranks.count.to_f
    end
  end
end
