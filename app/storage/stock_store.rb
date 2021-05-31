class StockStore
  def by_symbols(symbols)
    symbols = Array.wrap(symbols)
    companies = CompanyStore.new.by_symbols(symbols)
    companies = companies.group_by(&:symbol)
    symbols.map do |symbol|
      company = companies[symbol]&.first

      if company.blank?
        CompanyWorker.perform_async(symbol)
        Rails.logger.info("Symbol: #{symbol} sent for save.")
        next
      end

      args = {
        company: company,
        growth: GrowthStore.new.by_symbol_from_iex(symbol),
        quote: QuoteStore.new.by_symbol_from_tradier(symbol),
        stats: StatsStore.new.by_symbol_from_iex(symbol)
      }

      Entities::Stock.new(args)
    end.compact
  end

  def market_movers_by_key_from_cnn(key)
    symbols = Allocator.cnn_client.market_movers_by_key(key)
    by_symbols(symbols)
  end

  def market_movers_by_key_from_trading_view(key)
    symbols = Allocator.trading_view_client.market_movers_by_key(key)
    by_symbols(symbols)
  end
end
