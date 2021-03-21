module Scraper
  class TradingViewClient < ::BaseClient
    KEY_MAPPINGS = {
      StConstants::ACTIVE => "active",
      StConstants::GAINERS => "gainers",
      StConstants::LOSERS => "losers",
      StConstants::LARGE_CAP => "large-cap"
    }.with_indifferent_access.freeze
    MAX_SYMBOL_CHARACTER_SIZE = 5
    SYMBOLS_LIMIT = 10

    def market_movers_by_key(key)
      url_key = KEY_MAPPINGS[key]
      response = get("https://www.tradingview.com/markets/stocks-usa/market-movers-#{url_key}/").body
      Nokogiri::HTML(response).css(".tv-screener__symbol")
        .map(&:children).map(&:text)
        .select { |a| a.size <= MAX_SYMBOL_CHARACTER_SIZE }.first(SYMBOLS_LIMIT)
    end
  end
end
