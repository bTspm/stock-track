module Entities
  class Exchange < BaseEntity
    include HasDbEntity
    include HasElasticsearch

    ATTRIBUTES = %i[code country id name].freeze

    attr_accessor *ATTRIBUTES

    delegate :alpha2, :code, :name, :usa?, to: :country, prefix: true

    class << self
      def from_iex_company_response(response)
        id = _iex_exchange_mapping[response[:exchange]]
        new({ id: id })
      end

      def from_iex_response(response)
        args = {
          code: response[:exchange],
          country: Entities::Country.from_code(response[:region]),
          name: response[:description]
        }

        new(args)
      end

      private

      def _iex_exchange_mapping
        {
          "NEW YORK STOCK EXCHANGE, INC.": ::Exchange::NEW_YORK_STOCK_EXCHANGE_ID,
          "NASDAQ/NGS (GLOBAL SELECT MARKET)": ::Exchange::NASDAQ_GLOBAl_MARKET_ID,
          "NASDAQ CAPITAL MARKET": ::Exchange::NASDAQ_CAPITAL_MARKET_ID,
          "NASDAQ/NMS (GLOBAL MARKET)": ::Exchange::NASDAQ_GLOBAl_MARKET_ID
        }.with_indifferent_access
      end
    end
  end
end
