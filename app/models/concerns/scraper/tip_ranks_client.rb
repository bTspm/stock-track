module Scraper
  class TipRanksClient < BaseScraper
    CSS_CLASS_AND_KEY_MAPPING = {
      average: "hold",
      high: "high",
      low: "low",
    }

    def rating_by_symbol(symbol)
      get_response do
        @browser.goto("https://www.tipranks.com/stocks/#{symbol}/forecast")
        @browser
          .element(class: "client-components-stock-research-analysts-analyst-consensus-style__consensus")
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
        .css(".client-components-stock-research-analysts-price-target-style__ptInfoText")
        .css("strong")
        .first
        .text
        .to_i
    end

    def _rating(response)
      response
        .css(".client-components-stock-research-analysts-analyst-consensus-style__consensus")
        .css("p")
        .first
        .text
    end

    def _price_target(response)
      CSS_CLASS_AND_KEY_MAPPING.each_with_object(Hash.new) do |(key, css_class), hash|
        hash[key] = response
                      .css("strong.client-components-stock-research-analysts-price-target-style__#{css_class}")
                      .css("span")
                      .first
                      .text
                      .to_float
      end
    end
  end
end
