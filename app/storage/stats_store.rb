class StatsStore
  include Allocator::ApiClients

  def by_symbol_from_iex(symbol)
    response = iex_client.information_by_symbols(symbols: symbol, options: { types: "stats" })
    Entities::Stats.from_iex_response(response.body.values.first[:stats])
  end
end
