class EarningsStore
  def eps_estimates_from_finn_hub(symbol)
    response = _finn_hub_client.eps_estimates(symbol)
    response.body[:data].map do |single_response|
      Entities::Earnings::EpsEstimate.from_finn_hub_response(single_response)
    end
  end

  def eps_from_finn_hub(symbol)
    response = _finn_hub_client.eps(symbol)
    response.body.map do |single_response|
      Entities::Earnings::Eps.from_finn_hub_response(single_response)
    end
  end

  private

  def _finn_hub_client
    Api::FinnHub::Client.new
  end
end
