class StockStore
  def market_movers_by_key_from_cnn(key)
    Allocator.cnn_client.market_movers_by_key(key)
  end

  def market_movers_by_key_from_trading_view(key)
    Allocator.trading_view_client.market_movers_by_key(key)
  end
end
