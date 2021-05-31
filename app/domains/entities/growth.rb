module Entities
  class Growth < BaseEntity
    ATTRIBUTES = %i[day_30
                    day_5
                    max
                    month_1
                    month_3
                    month_6
                    year_1
                    year_2
                    year_5
                    ytd].freeze

    attr_accessor *ATTRIBUTES

    class << self
      def from_iex_response(response)
        args = {
          day_30: _format(response[:day30ChangePercent]),
          day_5: _format(response[:day5ChangePercent]),
          max: _format(response[:maxChangePercent]),
          month_1: _format(response[:month1ChangePercent]),
          month_3: _format(response[:month3ChangePercent]),
          month_6: _format(response[:month6ChangePercent]),
          year_1: _format(response[:year1ChangePercent]),
          year_2: _format(response[:year2ChangePercent]),
          year_5: _format(response[:year5ChangePercent]),
          ytd: _format(response[:ytdChangePercent])
        }

        new(args)
      end

      private

      def _format(value)
        value.blank? ? nil : value * 100
      end
    end
  end
end
