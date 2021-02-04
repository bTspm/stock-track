module Scraper
  class TipRanksClient < BaseScraper
    def rating_by_symbol(symbol)
      get_response do
        @browser.goto("https://www.tipranks.com/stocks/#{symbol}/forecast")
        results = @browser
                    .element(class: "client-components-stock-research-analysts-analyst-consensus-style__consensus")
                    .wait_until(&:present?)
        results.elements(css: "p").first.text
      end
    end
  end
end
