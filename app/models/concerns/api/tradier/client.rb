module Api
  module Tradier
    class Client < ::BaseClient
      def initialize
        options = {
          auth: { type: BEARER, token: ENV["TRADIER_KEY"] },
          headers: { type: "accept", value: "application/json" }
        }

        super(options)
      end

      def quote_by_symbol(symbol)
        get "#{_url}/markets/quotes?symbols=#{symbol.gsub(".", "/")}"
      end

      def time_series(options)
        url = "#{_url}/markets/history?symbol=#{options[:symbol]}"
        url += "&interval=#{options[:interval]}"
        url += "&start=#{options[:start_datetime].to_date}" if options[:start_datetime].present?
        url += "&end=#{options[:end_datetime].to_date}" if options[:end_datetime].present?
        get(url)
      end

      private

      def _url
        "https://sandbox.tradier.com/v1"
      end
    end
  end
end
