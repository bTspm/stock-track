module Scraper
  class TipRanksClient < BaseScraper
    def analysis_by_symbol(symbol)
      get_response do
        @browser.goto("https://www.tipranks.com/stocks/#{symbol}/forecast")
        @browser
          .element(class: "minW80")
          .wait_until(&:present?)
        response = Nokogiri::HTML(@browser.html)

        args = {
          analysts_count: _analysts(response),
          original_rating: _rating(response),
          price_target: _price_target(response),
          source: Entities::ExternalAnalyses::Analysis::TIP_RANKS,
          url: @browser.url
        }

        Entities::ExternalAnalyses::Analysis.new(args)
      end
    end

    private

    def _analysts(response)
      response
        .css(".override.fontWeightbold.fontSize6")
        .first
        .text
        .to_i
    end

    def _rating(response)
      response
        .css(".fonth4_bold.aligncenter.mobile_mb0.mobile_fontSize3small.w12")
        .first
        .text
    end

    def _price_target(response)
      high, average, low = response
                             .css(".ml3.mobile_fontSize7.laptop_ml0")
                             .map(&:text)
                             .map(&:to_float)

      {
        high: high,
        average: average,
        low: low
      }
    end
  end
end
