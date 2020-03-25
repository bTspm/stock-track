module Entities
  module Earnings
    class Eps
      attr_reader :actual,
                  :date,
                  :estimate

      def initialize(args = {})
        @actual = args[:actual]
        @date = args[:date]
        @estimate = args[:estimate]
      end

      def self.from_finn_hub_response(response)
        args = {
          actual: response[:actual],
          date: response[:period]&.to_date,
          estimate: response[:estimate]
        }

        new(args)
      end
    end
  end
end
