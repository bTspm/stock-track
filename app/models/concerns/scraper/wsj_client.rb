module Scraper
  class WsjClient < ::BaseClient
    PRICE_TARGET_HIGH_INDEX = 0
    PRICE_TARGET_LOW_INDEX = 2
    PRICE_TARGET_AVERAGE_INDEX = 3

    def analysis_by_symbol(symbol)
      url = "https://www.wsj.com/market-data/quotes/#{symbol}/research-ratings"
      response = Nokogiri::HTML(get(url).body)

      args = {
        analysts_count: _analysts_count(response),
        original_rating: response.css(".cr_analystRatings").css(".numValue-content").children.last.text.strip,
        price_target: _price_target(response),
        url: url,
        source: Entities::ExternalAnalyses::Analysis::WSJ
      }

      Entities::ExternalAnalyses::Analysis.new(args)
    end

    private

    def _analysts_count(response)
      response.css(".cr_analystRatings").css("tbody > tr").inject(0) do |sum, row|
        sum + row.css("td").last.text.to_integer
      end
    end

    def _price_target(response)
      price_targets_array = response
                              .css(".rr_stockprice")
                              .css(".data_data")
                              .children
                              .map { |a| a.text.to_float }
                              .compact

      {
        low: price_targets_array[PRICE_TARGET_LOW_INDEX],
        average: price_targets_array[PRICE_TARGET_AVERAGE_INDEX],
        high: price_targets_array[PRICE_TARGET_HIGH_INDEX]
      }
    end
  end
end
