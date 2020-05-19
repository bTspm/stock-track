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

    attr_reader *ATTRIBUTES

    def self.from_iex_response(response)
      args = {
       day_30: response[:day30ChangePercent],
       day_5: response[:day5ChangePercent],
       max: response[:maxChangePercent],
       month_1: response[:month1ChangePercent],
       month_3: response[:month3ChangePercent],
       month_6: response[:month6ChangePercent],
       year_1: response[:year1ChangePercent],
       year_2: response[:year2ChangePercent],
       year_5: response[:year5ChangePercent],
       ytd: response[:ytdChangePercent]
      }

      new(args)
    end
  end
end
