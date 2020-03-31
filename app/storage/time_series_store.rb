class TimeSeriesStore
  def time_series_from_twelve_data(options)
    response = _twelve_data_client.time_series(options)
    response.body[:values].map do |time_series_response|
      Entities::TimeSeries.from_twelve_data_response(time_series_response)
    end
  end

  private

  def _twelve_data_client
    Api::TwelveData::Client.new
  end
end
