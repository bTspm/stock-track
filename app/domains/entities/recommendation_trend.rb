module Entities
  class RecommendationTrend
    attr_reader :buy,
                :date,
                :hold,
                :sell,
                :strong_buy,
                :strong_sell

    def initialize(args = {})
      @buy = args[:buy]
      @date = args[:date]
      @hold = args[:hold]
      @sell = args[:sell]
      @strong_buy = args[:strong_buy]
      @strong_sell = args[:strong_sell]
    end

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
