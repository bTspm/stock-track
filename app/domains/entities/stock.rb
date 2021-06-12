module Entities
  class Stock < BaseEntity
    COMPANY = :company
    EARNINGS = :earnings
    GROWTH = :growth
    QUOTE = :quote
    NEWS = :news
    STATS = :stats
    TIME_SERIES = :time_series

    ATTRIBUTES = [
      COMPANY,
      EARNINGS,
      GROWTH,
      QUOTE,
      NEWS,
      STATS,
      TIME_SERIES
    ].freeze

    DEFAULT_ATTRS = [
      COMPANY,
      GROWTH,
      QUOTE,
      STATS,
    ]
    EXTERNAL_DATA_ATTRS = ATTRIBUTES - [COMPANY]
    INFO_ATTRS = ATTRIBUTES - [TIME_SERIES]
    MARKET_MOVER_ATTRS = DEFAULT_ATTRS
    WATCH_LIST_ATTRS = ATTRIBUTES - [TIME_SERIES, EARNINGS]

    attr_accessor *ATTRIBUTES
  end
end
