class TimeSeriesRequest
  DAY1 = "1day".freeze
  DEFAULT_INTERVAL = DAY1

  def initialize(options)
    @end_date_with_time = options[:end_date_with_time]&.strftime("%Y-%m-%d %H:%M:%S")
    @interval = options[:interval] || DEFAULT_INTERVAL
    @start_date_with_time = options[:start_date_with_time]&.strftime("%Y-%m-%d %H:%M:%S")
    @symbol = options[:symbol]
  end

  def to_options
    {
     end_date_with_time: @end_date_with_time,
     interval: @interval,
     start_date_with_time: @start_date_with_time,
     symbol: @symbol
    }
  end

  def self.five_year(symbol)
    args = {
     end_date_with_time: (DateTime.now).end_of_day,
     start_date_with_time: DateTime.now - 6.years,
     interval: DAY1,
     symbol: symbol,
    }

    new(args)
  end
end
