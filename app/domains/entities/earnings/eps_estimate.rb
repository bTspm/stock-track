module Entities
  module Earnings
    class EpsEstimate
      attr_reader :analysts_count,
                  :average,
                  :date,
                  :high,
                  :low

      def initialize(args = {})
        @analysts_count = args[:analysts_count]
        @average = args[:average]
        @date = args[:date]
        @high = args[:high]
        @low = args[:low]
      end

      def self.from_finn_hub_response(response)
        args = {
          analysts_count: response[:numberAnalysts],
          average: response[:epsAvg],
          date: response[:period]&.to_date,
          high: response[:epsHigh],
          low: response[:epsLow]
        }

        new(args)
      end
    end
  end
end
