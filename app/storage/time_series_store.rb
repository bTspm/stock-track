class TimeSeriesStore
  include Allocator::ApiClients
  include Cacheable

  def by_symbol_from_twelve_data(options)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{options}") do
      response = twelve_data_client.time_series(options)
      response.body[:values].map do |time_series_response|
        Entities::TimeSeries.from_twelve_data_response(time_series_response)
      end
    end
  end

  protected

  def _expiry
    30.minutes
  end
end
