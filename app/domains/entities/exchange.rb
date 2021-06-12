module Entities
  class Exchange < BaseEntity
    include HasDbEntity
    include HasElasticsearch

    ATTRIBUTES = %i[code country id name].freeze
    NASDAQ_CAPITAL_MARKET_ID = 2
    NYSE_ARCA = 3
    NASDAQ_GLOBAL_MARKET_ID = 7
    NEW_YORK_STOCK_EXCHANGE_ID = 11
    NASDAQ_IDS = [NASDAQ_CAPITAL_MARKET_ID, NASDAQ_GLOBAL_MARKET_ID]

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
          "NEW YORK STOCK EXCHANGE, INC.": NEW_YORK_STOCK_EXCHANGE_ID,
          "NYSE ARCA": NYSE_ARCA,
          "NASDAQ/NGS (GLOBAL SELECT MARKET)": NASDAQ_GLOBAL_MARKET_ID,
          "NASDAQ CAPITAL MARKET": NASDAQ_CAPITAL_MARKET_ID,
          "NASDAQ/NMS (GLOBAL MARKET)": NASDAQ_GLOBAL_MARKET_ID
        }.with_indifferent_access
      end
    end

    def nasdaq?
      Exchange::NASDAQ_IDS.include? id
    end
    
    def nyse?
      id == Exchange::NEW_YORK_STOCK_EXCHANGE_ID
    end
  end
end
