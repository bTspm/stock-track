class TimeSeriesStore
  include ApiClients
  include Cacheable

  def by_symbol_from_twelve_data(options)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{options}") do
      response = twelve_data_client.time_series(options)
      response.body[:values].map { |datum| Entities::TimeSeries.from_twelve_data_response(datum) }
    end
  end

  protected

  def _expiry
    30.minutes
  end
end
