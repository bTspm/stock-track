class QuoteStore
  include Cacheable

  def by_symbol_from_iex(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      response = Allocator.iex_client.information_by_symbols(symbols: symbol, options: { types: "quote" })
      Entities::Quote.from_iex_response(response.body.values.first[:quote])
    end
  end

  def by_symbol_from_tradier(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      response = Allocator.tradier_client.quote_by_symbol(symbol)
      Entities::Quote.from_tradier_response(response.body.dig(:quotes, :quote))
    end
  end

  protected

  def _expiry
    15.minutes
  end
end
