module Scraper
  class BarChartClient < BaseScraper
    CURRENT_RATING_INDEX = 3
    PRICE_TARGETS_COUNT = 3

    def rating_by_symbol(symbol)
      get_response do
        @browser.goto("https://www.barchart.com/stocks/quotes/#{symbol}/analyst-ratings")
        @browser
          .element(class: "chart-header")
          .wait_until(&:present?)
        response = Nokogiri::HTML(@browser.html)

        args = {
          analysts_count: _analysts(response),
          original_rating: _rating(response),
          price_target: _price_target(response),
          url: @browser.url,
          source: Entities::ExternalAnalyses::Analysis::BAR_CHART
        }

        Entities::ExternalAnalyses::Analysis.new(args)
      end
    end

    private

    def _analysts(response)
      response
        .css("div.average-column")[CURRENT_RATING_INDEX]
        .children
        .css("span.bold")
        .map(&:text)
        .join
        .to_i
    end

    def _price_target(response)
      high, average, low = response
                             .css("div.chart-header")
                             .map(&:text)
                             .first
                             .split(/(\n)/)
                             .reject(&:empty?)
                             .map(&:to_float)
                             .compact
                             .take(PRICE_TARGETS_COUNT)

      {
        average: average,
        high: high,
        low: low
      }
    end

    def _rating(response)
      response
        .css("div.average-column")[CURRENT_RATING_INDEX]
        .children
        .css("div.block__colored-header")
        .map(&:text)
        .join("")
        .strip
    end
  end
end
