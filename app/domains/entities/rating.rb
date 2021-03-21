module Entities
  class Rating < BaseEntity
    ATTRIBUTES = [
      :rating,
      :source
    ].freeze

    BAR_CHART = "Bar Chart"
    NASDAQ_COM = "NASDAQ.com"
    TIP_RANKS = "Tip Ranks"
    THE_STREET = "The Street"
    WE_BULL = "We Bull"
    YAHOO = "Yahoo"
    ZACKS = "Zacks"

    attr_reader *ATTRIBUTES
  end
end
