module Scraper
  class TheStreetClient < BaseScraper
    def rating_by_symbol(symbol)
      get_response do
        @browser.goto("https://www.thestreet.com/quote/#{symbol}")
        result = @browser
          .element(class: "m-market-data-quant-rating--item")
          .wait_until(&:present?)
        _extract_rating_from_response
      end
    end

    private

    def _extract_rating_from_response
      Nokogiri::HTML(@browser.html)
        .css("div.m-market-data-quant-rating--data")
        .text
        .gsub("\n", "")
        .strip
        .split(" ")
        .join(" ")
    end
  end
end
