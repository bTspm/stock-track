class StatsStore
  include Allocator::ApiClients
  include Cacheable

  def by_symbol_from_iex(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      response = iex_client.information_by_symbols(symbols: symbol, options: { types: "stats" })
      Entities::Stats.from_iex_response(response.body.values.first[:stats])
    end
  end

  protected

  def _expiry
    15.minutes
  end
end
