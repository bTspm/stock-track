class QuoteStore
  include Allocator::ApiClients

  def by_symbol_from_iex(symbol)
    response = iex_client.information_by_symbols(symbols: symbol, options: {types: 'quote'})
    Entities::Quote.from_iex_response(response.body.values.first[:quote])
  end
end
