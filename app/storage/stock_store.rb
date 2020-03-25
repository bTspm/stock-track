class StockStore
  def news_by_symbol(symbol:, count: 4)
    response = _client.news_by_symbol(symbol: symbol, count: count)
    response.body.map { |news_article| NewsArticle.new(news_article) }
  end

  def stock_by_symbol(symbol)
    options = {last: 4, types: 'logo,news,quote,stats'}
    response = _client.information_by_symbols(symbols: symbol, options: options)
    _validate_and_build_stock_details(response)
  end

  def company_by_symbol(symbols)
    response = _client.information_by_symbols(symbols: symbols, options: {types: 'company'})
    _validate_and_build_company_details(response)
  end

  def create_stock(stock)
    stock.save!
  end

  private

  def _validate_and_build_stock_details(response)
    _validate_response(response)
    Stock.new(response.body.values.first)
  end

  def _validate_and_build_company_details(response)
    _validate_response(response)

    response.body.values.map do |stock|
      IexDeserializers::Stock.new.from_response(stock)
    end
  end

  def _client
    Api::Iex::Client.new
  end

  def _validate_response(response)
    return if response.success
    raise Exceptions::AppExceptions::ApiError.new(response)
  end
end
