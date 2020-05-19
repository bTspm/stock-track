module Entities
  class EpsEstimate < BaseEntity
    ATTRIBUTES = %i[analysts_count
                    average
                    date
                    high
                    low].freeze

    attr_reader *ATTRIBUTES

    def self.from_finn_hub_response(response)
      args = {
       analysts_count: response[:numberAnalysts],
       average: response[:epsAvg],
       date: response[:period].to_date,
       high: response[:epsHigh],
       low: response[:epsLow]
      }

      new(args)
    end
  end
end
