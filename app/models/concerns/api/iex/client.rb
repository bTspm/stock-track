module Api
  module Iex
    class Client < ::BaseClient
      DEFAULT_NEWS_COUNT = 4

      def exchanges
        get "#{_ref_data_url}/exchanges?token=#{_key}"
      end

      def information_by_symbols(symbols:, options:)
        get _build_url(symbols: symbols, options: options)
      end

      def news_by_symbol(symbol:, count: DEFAULT_NEWS_COUNT)
        get "#{_url}/#{symbol}/news/last/#{count}?token=#{_key}"
      end

      private

      def _build_url(symbols:, options:)
        "#{_url}/market/batch?token=#{_key}&symbols=#{symbols}&types=#{options[:types]}"
      end

      def _key
        ENV["IEX_CLOUD_KEY"]
      end

      def _ref_data_url
        "https://cloud.iexapis.com/stable/ref-data"
      end

      def _url
        "https://cloud.iexapis.com/v1/stock"
      end
    end
  end
end
