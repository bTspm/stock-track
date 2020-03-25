module Api
  module TwelveData
    class Client < ::Api::BaseClient
      def time_series(options)
        url = "#{_url}/time_series?symbol=#{options[:symbol]}"
        url += "&interval=#{options[:interval]}"
        url += "&start_date=#{options[:start_date_with_time]}" if options[:start_date_with_time].present?
        url += "&end_date=#{options[:end_date_with_time]}" if options[:end_date_with_time].present?
        url += "&apikey=#{_key}"
        get(url)
      end

      private

      def _key
        ENV["TWELVE_DATA_KEY"]
      end

      def _url
        "https://api.twelvedata.com"
      end
    end
  end
end
