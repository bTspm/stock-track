module Scraper
  class BarChartClient < ::BaseClient
    CURRENT_RATING_INDEX = 3

    def rating_by_symbol(symbol)
      url = "https://www.barchart.com/stocks/quotes/#{symbol}/analyst-ratings"
      response = Nokogiri::HTML(get(url).body).css("div.average-column")[CURRENT_RATING_INDEX].children

      args = {
        analysts_count: _analysts(response),
        original_rating: _rating(response),
        url: url,
        source: Entities::ExternalAnalyses::Analysis::BAR_CHART
      }

      Entities::ExternalAnalyses::Analysis.new(args)
    end

    private

    def _analysts(response)
      response
        .css("span.bold")
        .map(&:text)
        .join
        .to_i
    end

    def _rating(response)
      response
        .css("div.block__colored-header")
        .map(&:text)
        .join("")
        .strip
    end
  end
end
