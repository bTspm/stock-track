module Scraper
  class TradingView < ::BaseClient
    KEY_MAPPINGS = {
      active: "active",
      gainers: "gainers",
      losers: "losers",
      large_cap: "large-cap"
    }.with_indifferent_access.freeze
    MAX_SYMBOL_CHARACTER_SIZE = 5

    def market_movers_by_key(key)
      url_key = KEY_MAPPINGS[key]
      web_response = get("https://www.tradingview.com/markets/stocks-usa/market-movers-#{url_key}/").body
      _extract_symbols_from_response(web_response)
    end

    private

    def _extract_symbols_from_response(response)
      Nokogiri::HTML(response).css(".tv-screener__symbol")
              .map(&:children).map(&:text)
              .select { |a| a.size <= MAX_SYMBOL_CHARACTER_SIZE }
    end
  end
end
