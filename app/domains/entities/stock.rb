module Entities
  class Stock < BaseEntity
    COMPANY = :company
    EARNINGS = :earnings
    EXTERNAL_ANALYSIS = :external_analysis
    GROWTH = :growth
    QUOTE = :quote
    NEWS = :news
    STATS = :stats
    TIME_SERIES = :time_series

    ATTRIBUTES = [
      COMPANY,
      EARNINGS,
      EXTERNAL_ANALYSIS,
      GROWTH,
      QUOTE,
      NEWS,
      STATS,
      TIME_SERIES
    ].freeze

    attr_accessor *ATTRIBUTES

    delegate :volume, to: :quote
    delegate :market_cap, to: :stats
    delegate :average_rating_rank, :total_analysts, to: :external_analysis

    def latest_earnings
      return if earnings.blank?

      earnings.sort_by(&:date).reverse.find { |earning| earning.surprise.present? }
    end
  end
end
