class TimeSeriesStore
  include Allocator::ApiClients

  def by_symbol_from_twelve_data(options)
    response = twelve_data_client.time_series(options)
    response.body[:values].map do |time_series_response|
      Entities::TimeSeries.from_twelve_data_response(time_series_response)
    end
  end
end
