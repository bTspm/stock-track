class RecommendationTrendStore
  include Allocator::ApiClients

  def by_symbol_from_finn_hub(symbol)
    response = finn_hub_client.recommendation_trends(symbol)
    response.body.map do |single_response|
      Entities::RecommendationTrend.from_finn_hub_response(single_response)
    end
  end
end
