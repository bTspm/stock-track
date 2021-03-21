module Scraper
  class ZacksClient < ::BaseClient
    def rating_by_symbol(symbol)
      response = get("https://www.zacks.com/stock/quote/#{symbol}/").body
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
