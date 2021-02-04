module Scraper
  class BarChartClient < ::BaseClient
    def rating_by_symbol(symbol)
      web_response = get("https://www.barchart.com/stocks/quotes/#{symbol}/opinion").body
      _extract_rating_from_response(web_response)
    end

    private

    def _extract_rating_from_response(response)
      Nokogiri::HTML(response)
        .css("div.opinion-status")
        .css("span")
        .map(&:text)
        .join(" ")
    end
  end
end
