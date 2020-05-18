module Entities
  class RecommendationTrend
    include BaseEntity

    ATTRIBUTES = %i[buy
                    date
                    hold
                    sell
                    strong_buy
                    strong_sell].freeze

    attr_reader *ATTRIBUTES

    def self.from_finn_hub_response(response)
      args = {
       buy: response[:buy],
       date: response[:period]&.to_date,
       hold: response[:hold],
       sell: response[:sell],
       strong_buy: response[:strongBuy],
       strong_sell: response[:strongSell]
      }

      new(args)
    end
  end
end
