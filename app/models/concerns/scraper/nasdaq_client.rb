module Scraper
  class NasdaqClient < BaseScraper
    def rating_by_symbol(symbol)
      get_response do
        @browser.goto("https://www.nasdaq.com/market-activity/stocks/#{symbol}/analyst-research")
        results = @browser
                    .element(class: "upgrade-downgrade-b__summary")
                    .wait_until(&:present?)
        results.elements(css: "span").map(&:text).last
      end
    end
  end
end
