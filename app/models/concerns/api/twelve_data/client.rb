module Api
  module TwelveData
    class Client < ::Api::BaseClient
      def time_series(options)
        url = "#{_url}/time_series?symbol=#{options[:symbol]}"
        url += "&interval=#{options[:interval]}"
        url += "&start_date=#{options[:start_datetime]}" if options[:start_datetime].present?
        url += "&end_date=#{options[:end_datetime]}" if options[:end_datetime].present?
        url += "&apikey=#{_key}"
        get(url)
      end

      private

      def _key
        ENV["TWELVE_DATA_KEY"]
      end

      def _response_handler
        Api::TwelveData::RaiseHttpException
      end

      def _url
        "https://api.twelvedata.com"
      end
    end
  end
end
