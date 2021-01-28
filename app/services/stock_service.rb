class StockService < BusinessService
  include Services

  def save_exchanges
    exchange_storage.save_exchanges
  end

  def earnings_by_symbol(symbol)
    {
      eps_estimates: earnings_storage.eps_estimates_from_finn_hub_by_symbol(symbol),
      eps_surprises: earnings_storage.eps_surprises_from_finn_hub_by_symbol(symbol)
    }
  end

  def growth_by_symbol(symbol)
    growth_storage.by_symbol_from_iex(symbol)
  end

  def market_movers_by_key(key)
    if StConstants::CNN_MARKET_MOVER_KEYS.include? key
      stock_storage.market_movers_by_key_from_cnn(key)
    else
      stock_storage.market_movers_by_key_from_trading_view(key)
    end
  end

  def news_by_symbol(symbol)
    news_storage.by_symbol_from_iex(symbol: symbol)
  end

  def quote_by_symbol(symbol)
    quote_storage.by_symbol_from_iex(symbol)
  end

  def recommendation_trends_by_symbol(symbol)
    recommendation_trend_storage.by_symbol_from_finn_hub(symbol)
  end

  def stats_by_symbol(symbol)
    stats_storage.by_symbol_from_iex(symbol)
  end

  def stocks_by_symbols(symbols)
    stock_storage.by_symbols(symbols)
  end

  def time_series_by_symbol(symbol)
    time_series_storage.by_symbol_from_twelve_data(_time_series_5year_options(symbol))
  end

  private

  def _time_series_5year_options(symbol)
    TimeSeriesRequest.five_year(symbol).to_options
  end
end
