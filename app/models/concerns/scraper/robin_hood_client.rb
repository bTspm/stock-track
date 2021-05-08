module Scraper
  class RobinHoodClient < ::BaseClient
    def analysis_by_symbol(symbol)
      url = "https://robinhood.com/stocks/#{symbol}"
      response = Nokogiri::HTML(get(url).body)

      args = {
        analysts_count: response.css("._1fEdz1YPOLpLW1Ow3rKh92").css("p").text.to_integer,
        original_rating: _rating(response),
        url: url,
        source: Entities::ExternalAnalyses::Analysis::ROBIN_HOOD
      }

      Entities::ExternalAnalyses::Analysis.new(args)
    end

    private

    def _rating(response)
      ratings = response.css("._1WW-0CEc7nCIXcX_BxxJeH").map { |node| node.text.to_float }
      return nil if ratings.all?(&:nil?)

      buy, hold, sell = ratings
      {
        buy: buy || -1,
        hold: hold || -1,
        sell: sell || -1
      }.max_by{|_,v| v}.first.to_s.titleize
    end
  end
end
