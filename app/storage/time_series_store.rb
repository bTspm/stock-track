class TimeSeriesStore
  include Cacheable
  def by_symbol_from_tradier(options)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{options}") do
      response = Allocator.tradier_client.time_series(options)
      response.body.dig(:history, :day).map { |datum| Entities::TimeSeries.from_tradier_response(datum) }
    end
  end

  protected

  def _expiry
    30.minutes
  end
end
