module Scraper
  class CnnClient < ::BaseClient
    INDEX_DEF = {
      StConstants::ACTIVE => 0,
      StConstants::GAINERS => 1,
      StConstants::LOSERS => 2
    }.with_indifferent_access

    def market_movers_by_key(key)
      response = get("https://money.cnn.com/data/hotstocks/").body
      symbols = Nokogiri::HTML(response).css(".wsod_dataTable").map do |table|
        table.css("a.wsod_symbol").children.map(&:text)
      end

      symbols[INDEX_DEF[key]]
    end
  end
end
