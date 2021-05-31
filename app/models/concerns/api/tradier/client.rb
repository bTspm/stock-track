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

      private

      def _url
        "https://sandbox.tradier.com/v1"
      end
    end
  end
end
