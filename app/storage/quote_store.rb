class QuoteStore
  include ApiClients
  include Cacheable

  def by_symbol_from_iex(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      response = iex_client.information_by_symbols(symbols: symbol, options: { types: "quote" })
      Entities::Quote.from_iex_response(response.body.values.first[:quote])
    end
  end

  protected

  def _expiry
    15.minutes
  end
end
