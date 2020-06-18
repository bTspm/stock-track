class EarningsStore
  include Allocator::ApiClients
  include Cacheable

  def eps_estimates_from_finn_hub_by_symbol(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      response = finn_hub_client.eps_estimates(symbol)
      response.body[:data].map { |datum| Entities::EpsEstimate.from_finn_hub_response(datum) }
    end
  rescue ApiExceptions::PremiumDataError
    []
  end

  def eps_surprises_from_finn_hub_by_symbol(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      response = finn_hub_client.eps_surprises(symbol)
      response.body.map { |datum| Entities::EpsSurprise.from_finn_hub_response(datum) }
    end
  end
end
