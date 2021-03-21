module Scraper
  class BarChartClient < ::BaseClient
    def rating_by_symbol(symbol)
      response = get("https://www.barchart.com/stocks/quotes/#{symbol}/opinion").body
      Nokogiri::HTML(response)
        .css("div.opinion-status")
        .css("span")
        .map(&:text)
        .join(" ")
    end
  end
end
