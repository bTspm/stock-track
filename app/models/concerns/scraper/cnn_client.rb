module Scraper
  class CnnClient < ::BaseClient
    INDEX_DEF = {
      StConstants::ACTIVE => 0,
      StConstants::GAINERS => 1,
      StConstants::LOSERS => 2
    }.with_indifferent_access
    PRICE_TARGET_RANGE = 2..4

    def analysis_by_symbol(symbol)
      url = "https://money.cnn.com/quote/forecast/forecast.html?symb=#{symbol.gsub(".", "")}"
      response = Nokogiri::HTML(get(url).body)
      price_target_response, rating_response = response.css(".wsod_twoCol")

      args = {
        analysts_count: rating_response.text.to_integer,
        original_rating: response.css(".wsod_rating").first.text,
        price_target: _price_target(price_target_response),
        url: url,
        source: Entities::ExternalAnalyses::Analysis::CNN
      }

      Entities::ExternalAnalyses::Analysis.new(args)
    end

    def market_movers_by_key(key)
      response = get("https://money.cnn.com/data/hotstocks/").body
      symbols = Nokogiri::HTML(response).css(".wsod_dataTable").map do |table|
        table.css("a.wsod_symbol").children.map(&:text)
      end

      symbols[INDEX_DEF[key]]
    end

    private

    def _price_target(response)
      average, high, low = response.text.to_floats[PRICE_TARGET_RANGE]

      {
        low: low,
        average: average,
        high: high
      }
    end
  end
end
