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
  end
end
