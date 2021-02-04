module Scraper
  class ZacksClient < ::BaseClient
    def rating_by_symbol(symbol)
      web_response = get("https://www.zacks.com/stock/quote/#{symbol}/").body
      _extract_rating_from_response(web_response)
    end

    private

    def _extract_rating_from_response(response)
      Nokogiri::HTML(response)
        .css("p.rank_view")
        .map(&:text)
        .first
        .gsub!(/[^A-Za-z ]/, '')
        .remove("of")
        .strip!
    end
  end
end
