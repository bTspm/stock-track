class TimeSeriesStore
  def time_series_from_twelve_data(options)
    response = _twelve_data_client.time_series(options)
    ::TwelveDataDeserializers::TimeSeries.new.from_response(response.body)
  end

  private

  def _twelve_data_client
    Api::TwelveData::Client.new
  end
end
