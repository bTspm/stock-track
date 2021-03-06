module Api
  module FinnHub
    class Client < ::BaseClient
      def company_executives(symbol)
        get "#{_url}/executive?symbol=#{_format_symbol(symbol)}&token=#{_key}"
      end

      def eps_surprises(symbol)
        get "#{_url}/earnings?symbol=#{_format_symbol(symbol)}&token=#{_key}"
      end

      def symbols_by_exchange(exchange)
        get "#{_url}/symbol?exchange=#{exchange.upcase}&token=#{_key}"
      end

      private

      def _format_symbol(symbol)
        symbol.gsub(".", "-")
      end

      def _key
        ENV["FINNHUB_KEY"]
      end

      def _response_handler
        Api::FinnHub::RaiseHttpException
      end

      def _url
        "https://finnhub.io/api/v1/stock"
      end
    end
  end
end
