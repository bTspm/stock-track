class RecommendationTrendStore
  def recommendation_trends_from_finn_hub(symbol)
    response = _finn_hub_client.recommendation_trends(symbol)
    response.body.map do |single_response|
      Entities::RecommendationTrend.from_finn_hub_response(single_response)
    end
  end

  private

  def _finn_hub_client
    Api::FinnHub::Client.new
  end
end
