class StockService < BusinessService
  include Services

  COMPARE_STOCK_ATTRS = Entities::Stock::ATTRIBUTES
  DEFAULT_STOCK_ATTRS = [
    Entities::Stock::COMPANY,
    Entities::Stock::GROWTH,
    Entities::Stock::QUOTE,
    Entities::Stock::STATS,
  ]
  EXTERNAL_DATA_STOCK_ATTRS = Entities::Stock::ATTRIBUTES - [Entities::Stock::COMPANY]
  INFO_STOCK_ATTRS = Entities::Stock::ATTRIBUTES - [Entities::Stock::TIME_SERIES]
  MARKET_MOVER_STOCK_ATTRS = DEFAULT_STOCK_ATTRS
  WATCH_LIST_STOCK_ATTRS = Entities::Stock::ATTRIBUTES - [Entities::Stock::TIME_SERIES, Entities::Stock::EARNINGS]

  def market_movers_by_key(key)
    symbols = if StConstants::CNN_MARKET_MOVER_KEYS.include? key
                stock_storage.market_movers_by_key_from_cnn(key)
              else
                stock_storage.market_movers_by_key_from_trading_view(key)
              end
    stocks_by_symbols(symbols: symbols, attrs: MARKET_MOVER_STOCK_ATTRS)
  end

  def stock_info_by_symbol(symbol)
    stocks_by_symbols(symbols: symbol, attrs: INFO_STOCK_ATTRS).first
  end

  def stocks_for_compare(symbols)
    stocks_by_symbols(symbols: symbols, attrs: COMPARE_STOCK_ATTRS)
  end

  def stocks_for_watch_list(symbols)
    stocks_by_symbols(symbols: symbols, attrs: WATCH_LIST_STOCK_ATTRS)
  end

  def stocks_by_symbols(symbols:, attrs: DEFAULT_STOCK_ATTRS)
    symbols = Array.wrap(symbols).compact.uniq.map(&:downcase)
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

  def _init_stock(company:, attrs: DEFAULT_STOCK_ATTRS)
    args = attrs.each_with_object(Hash.new) do |attr, hash|
      hash[attr] = case attr
                   when Entities::Stock::COMPANY
                     company
                   when Entities::Stock::EARNINGS
                     earnings_storage.by_symbol_from_finn_hub(company.symbol)
                   when Entities::Stock::EXTERNAL_ANALYSIS
                     Entities::ExternalAnalysis.from_json(company.external_analysis)
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
