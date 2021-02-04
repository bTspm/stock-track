module Entities
  class Rating < BaseEntity
    ATTRIBUTES = [
      :rating,
      :source
    ].freeze
    attr_reader *ATTRIBUTES

    BAR_CHART = "Bar Chart"
    NASDAQ_COM = "NASDAQ.com"
    TIP_RANKS = "Tip Ranks"
    THE_STREET = "The Street"
    WE_BULL = "We Bull"
    YAHOO = "Yahoo"
    ZACKS = "Zacks"
  end
end
