module Scraper
  class TheStreetClient < ::BaseClient
    def analysis_by_symbol(symbol)
      args = {
        custom: _custom(symbol),
        original_rating: _rating(symbol),
        source: Entities::ExternalAnalyses::Analysis::THE_STREET,
        url: "https://www.thestreet.com/r/ratings/reports/summary/#{symbol}.html"
      }

      Entities::ExternalAnalyses::Analysis.new(args)
    end

    private

    def _rating(symbol)
      url = "https://www.thestreet.com/r/ratings/reports/summary/#{symbol}.html"
      response = Nokogiri::HTML(get(url).body)
      response.css("ul.tabContent").last.children[-2].text.gsub("Recommendation:", "").strip
    end

    def _custom(symbol)
      url = "https://www.thestreet.com/r/ratings/reports/detail/#{symbol}.html"
      response = Nokogiri::HTML(get(url).body)
      factors_with_scores = response.css("div#tabContainer").children.css("tr").each_with_index.map do |table, index|
        table.children.map(&:text).map(&:strip).reject(&:blank?).compact if index.odd?
      end.compact

      factors_with_scores.each_with_object(Hash.new) do |array, hash|
        hash["#{array.first.parameterize(separator: '_')}"] = array.last.to_float
      end
    end
  end
end
