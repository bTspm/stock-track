module Entities
  class TimeSeries < BaseEntity
    ATTRIBUTES = %i[close
                    datetime
                    high
                    low
                    open
                    volume].freeze

    attr_reader *ATTRIBUTES

    def self.from_twelve_data_response(response)
      args = {
        close: response[:close].to_f,
        datetime: response[:datetime].to_datetime,
        high: response[:high].to_f,
        low: response[:low].to_f,
        open: response[:open].to_f,
        volume: response[:volume].to_i
      }

      new(args)
    end
  end
end
