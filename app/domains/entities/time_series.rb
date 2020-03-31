module Entities
  class TimeSeries
    attr_reader :close,
                :date_time,
                :high,
                :low,
                :open,
                :volume

    def initialize(args = {})
      @close = args[:close]
      @date_time = args[:date_time]
      @high = args[:high]
      @low = args[:low]
      @open = args[:open]
      @volume = args[:volume]
    end

    def self.from_twelve_data_response(response)
      args = {
        close: response[:close].to_f,
        date_time: response[:datetime].to_datetime,
        high: response[:high].to_f,
        low: response[:low].to_f,
        open: response[:open].to_f,
        volume: response[:volume].to_i
      }

      new(args)
    end
  end
end
