class EarningsStore
  include Cacheable

  def by_symbol_from_finn_hub(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      response = Allocator.finn_hub_client.eps_surprises(symbol)
      response.body.map { |datum| Entities::EpsSurprise.from_finn_hub_response(datum) }
    end
  end
end
