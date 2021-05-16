module Entities
  module ExternalAnalyses
    module RatingMappings
      DEFAULT_MAPPING = {
        strong_buy: ["Strong Buy"],
        buy: ["Buy"],
        hold: ["Hold"],
        sell: ["Sell"],
        strong_sell: ["Strong Sell"]
      }

      SOURCE_AND_RATING_MAPPING = {
        Entities::ExternalAnalyses::Analysis::BAR_CHART => {
          strong_buy: ["Strong Buy"],
          buy: ["Buy", "Moderate Buy"],
          hold: ["Hold"],
          sell: ["Sell", "Moderate Sell"],
          strong_sell: ["Strong Sell"]
        },

        Entities::ExternalAnalyses::Analysis::TIP_RANKS => {
          strong_buy: ["Strong Buy"],
          buy: ["Buy", "Moderate Buy"],
          hold: ["Hold"],
          sell: ["Sell", "Moderate Sell"],
          strong_sell: ["Strong Sell"]
        },

        Entities::ExternalAnalyses::Analysis::THE_STREET => {
          strong_buy: ["A+(Buy)", "A(Buy)", "A-(Buy)"],
          buy: ["B+(Buy)", "B(Buy)", "B-(Buy)"],
          hold: ["C+(Hold)", "C(Hold)", "C-(Hold)"],
          sell: ["D+(Sell)", "D(Sell)", "D-(Sell)"],
          strong_sell: ["E+(Sell)", "E(Sell)", "E-(Sell)", "F(Sell)"]
        },

        Entities::ExternalAnalyses::Analysis::WE_BULL => {
          strong_buy: ["Strong Buy"],
          buy: ["Buy"],
          hold: ["Hold"],
          sell: ["Underperform"],
          strong_sell: ["Sell"]
        },

        Entities::ExternalAnalyses::Analysis::ZACKS => Entities::ExternalAnalyses::RatingMappings::DEFAULT_MAPPING,
        Entities::ExternalAnalyses::Analysis::CNN => Entities::ExternalAnalyses::RatingMappings::DEFAULT_MAPPING,
        Entities::ExternalAnalyses::Analysis::ROBIN_HOOD => Entities::ExternalAnalyses::RatingMappings::DEFAULT_MAPPING
      }
    end
  end
end
