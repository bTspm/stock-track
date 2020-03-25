module TwelveDataDeserializers
  class TimeSeries
    def from_response(response = {})
      return [] if response.blank?

      response[:values].map do |time_series_response|
        args = {
            close: time_series_response[:close].to_f,
            date_time: time_series_response[:datetime].to_datetime,
            high: time_series_response[:high].to_f,
            low: time_series_response[:low].to_f,
            open: time_series_response[:open].to_f,
            volume: time_series_response[:volume].to_i
        }

        Entities::TimeSeries.new(args)
      end
    end
  end
end
