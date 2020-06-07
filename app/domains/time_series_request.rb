class TimeSeriesRequest
  DAY1 = "1day".freeze
  DATE_FORMAT = "%Y-%m-%d %H:%M:%S"
  DEFAULT_INTERVAL = DAY1

  attr_reader :end_datetime,
              :interval,
              :start_datetime,
              :symbol

  def initialize(args = {})
    @end_datetime = args[:end_datetime] || _default_end_time
    @interval = args[:interval] || DEFAULT_INTERVAL
    @start_datetime = args[:start_datetime] || _default_start_date
    @symbol = args[:symbol]
  end

  def to_options
    {
     end_datetime: @end_datetime.strftime(DATE_FORMAT),
     interval: @interval,
     start_datetime: @start_datetime.strftime(DATE_FORMAT),
     symbol: @symbol
    }
  end

  def self.five_year(symbol)
    end_date = DateTime.now.end_of_day
    args = {
     end_datetime: end_date,
     start_datetime: end_date - 6.years,
     interval: DAY1,
     symbol: symbol
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
