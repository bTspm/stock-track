class TimeSeriesRequest
  DAY1 = "1day".freeze
  DATE_FORMAT = "%Y-%m-%d %H:%M:%S"
  DEFAULT_INTERVAL = DAY1

  attr_reader :end_date_with_time,
              :interval,
              :start_date_with_time,
              :symbol

  def initialize(args = {})
    @end_date_with_time = args[:end_date_with_time] || _default_end_time
    @interval = args[:interval] || DEFAULT_INTERVAL
    @start_date_with_time = args[:start_date_with_time] || _default_start_date
    @symbol = args[:symbol]
  end

  def to_options
    {
     end_date_with_time: @end_date_with_time.strftime(DATE_FORMAT),
     interval: @interval,
     start_date_with_time: @start_date_with_time.strftime(DATE_FORMAT),
     symbol: @symbol
    }
  end

  def self.five_year(symbol)
    end_date = DateTime.now.end_of_day
    args = {
     end_date_with_time: end_date,
     start_date_with_time: end_date - 6.years,
     interval: DAY1,
     symbol: symbol,
    }

    new(args)
  end

  private

  def _default_end_time
    DateTime.now.end_of_day
  end

  def _default_start_date
    _default_end_time - 1.month
  end
end
