class GrowthStore
  include Cacheable
  include Allocator::ApiClients

  def expiry
    10.minutes
  end

  def by_symbol_from_iex(symbol)
    fetch_cached("#{self.class.name}/#{__method__}/#{symbol}") do
      response = iex_client.information_by_symbols(symbols: symbol, options: { types: 'stats' })
      Entities::Growth.from_iex_response(response.body.values.first[:stats])
    end
  end
end
