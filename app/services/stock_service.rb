class StockService < BusinessService
  include Services

  def market_movers_by_key(key)
    symbols = if StConstants::CNN_MARKET_MOVER_KEYS.include? key
                stock_storage.market_movers_by_key_from_cnn(key)
              else
                stock_storage.market_movers_by_key_from_trading_view(key)
              end
    stocks_by_symbols(symbols: symbols, attrs: Entities::Stock::MARKET_MOVER_ATTRS)
  end

  def stock_info_by_symbol(symbol)
    stocks_by_symbols(symbols: symbol, attrs: Entities::Stock::INFO_ATTRS).first
  end

  def stocks_for_watch_list(symbols)
    stocks_by_symbols(symbols: symbols, attrs: Entities::Stock::WATCH_LIST_ATTRS)
  end

  def stocks_by_symbols(symbols:, attrs: Entities::Stock::DEFAULT_ATTRS)
    symbols = Array.wrap(symbols).map(&:downcase)
    companies = company_storage.by_symbols(symbols)
    companies = companies.group_by { |company| company.symbol.downcase }

    symbols.map do |symbol|
      company = companies[symbol]&.first
      next _save_missing_company(symbol) if company.blank?

      _init_stock(company: company, attrs: attrs)
    end.compact
  end

  def time_series_by_symbol(symbol)
    time_series_storage.by_symbol_from_twelve_data(TimeSeriesRequest.five_year(symbol).to_options)
  end

  private

  def _earnings(symbol)
    {
      eps_estimates: earnings_storage.eps_estimates_from_finn_hub_by_symbol(symbol),
      eps_surprises: earnings_storage.eps_surprises_from_finn_hub_by_symbol(symbol)
    }
  end

  def _init_stock(company:, attrs: Entities::Stock::DEFAULT_ATTRS)
    args = attrs.each_with_object(Hash.new) do |attr, hash|
      hash[attr] = case attr
                   when Entities::Stock::COMPANY
                     company
                   when Entities::Stock::EARNINGS
                     _earnings(company.symbol)
                   when Entities::Stock::GROWTH
                     growth_storage.by_symbol_from_iex(company.symbol)
                   when Entities::Stock::QUOTE
                     quote_storage.by_symbol_from_tradier(company.symbol)
                   when Entities::Stock::NEWS
                     news_storage.by_symbol_from_iex(symbol: company.symbol)
                   when Entities::Stock::STATS
                     stats_storage.by_symbol_from_iex(company.symbol)
                   when Entities::Stock::TIME_SERIES
                     time_series_by_symbol(company.symbol)
                   else
                     raise StandardError, "Unknown attr: #{attr} for symbol: #{company.symbol}"
                   end
    end

    Entities::Stock.new(args)
  end

  def _save_missing_company(symbol)
    CompanyWorker.perform_async(symbol)
    Rails.logger.info("Symbol: #{symbol} sent for save.")
    nil
  end
end
