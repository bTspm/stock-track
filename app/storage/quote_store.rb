class QuoteStore
  include Cacheable

  def by_symbol_from_iex(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      response = Allocator.iex_client.information_by_symbols(symbols: symbol, options: { types: "quote" })
      Entities::Quote.from_iex_response(response.body.values.first[:quote])
    end
  end

  protected

  def _expiry
    5.hours
  end
end
