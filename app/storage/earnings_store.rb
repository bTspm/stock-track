class EarningsStore
  include Allocator::ApiClients

  def eps_estimates_from_finn_hub(symbol)
    response = finn_hub_client.eps_estimates(symbol)
    response.body[:data].map do |single_response|
      Entities::EpsEstimate.from_finn_hub_response(single_response)
    end
  end

  def eps_surprises_from_finn_hub(symbol)
    response = finn_hub_client.eps_surprises(symbol)
    response.body.map do |single_response|
      Entities::EpsSurprise.from_finn_hub_response(single_response)
    end
  end
end
