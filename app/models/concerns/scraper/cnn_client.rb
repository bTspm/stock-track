module Scraper
  class CnnClient < ::BaseClient
    INDEX_DEF = {
      StConstants::ACTIVE => 0,
      StConstants::GAINERS => 1,
      StConstants::LOSERS => 2
    }

    def market_movers_by_key(key)
      web_response = get("https://money.cnn.com/data/hotstocks/").body
      _extract_symbols_from_response(web_response, key)
    end

    private

    def _extract_symbols_from_response(response, key)
      symbols = Nokogiri::HTML(response).css(".wsod_dataTable").map do |table|
        table.css("a.wsod_symbol").children.map(&:text)
      end

      symbols[INDEX_DEF.with_indifferent_access[key]]
    end
  end
end
