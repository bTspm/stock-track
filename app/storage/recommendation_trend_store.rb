class RecommendationTrendStore
  include Allocator::ApiClients
  include Cacheable

  def by_symbol_from_finn_hub(symbol)
    fetch_cached(key: "#{self.class.name}/#{__method__}/#{symbol}") do
      response = finn_hub_client.recommendation_trends(symbol)
      response.body.map do |single_response|
        Entities::RecommendationTrend.from_finn_hub_response(single_response)
      end
    end
  end
end
