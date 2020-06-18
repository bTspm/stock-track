require "rails_helper"

describe RecommendationTrendStore do
  let(:cache_key) { "key" }
  let(:domain_class) { Entities::RecommendationTrend }
  subject(:store) { described_class.new }

  before do
    Rails.cache.clear
    allow_any_instance_of(described_class).to receive(:fetch_cached).with(key: cache_key).and_call_original
  end

  describe "#by_symbol_from_finn_hub" do
    let(:cache_key) { "RecommendationTrendStore/by_symbol_from_finn_hub/ABC" }
    let(:recommendation_trend_response) { double(:recommendation_trend_response) }
    let(:response) { double(:response, body: [recommendation_trend_response]) }
    let(:symbol) { "ABC" }

    subject { store.by_symbol_from_finn_hub(symbol) }

    it "expect to call information_by_symbols and build recommendation_trend" do
      expect(store).to receive_message_chain(:finn_hub_client, :recommendation_trends ).with(symbol) { response }
      expect(
        domain_class
      ).to receive(:from_finn_hub_response).with(recommendation_trend_response) { "RecommendationTrend Domain" }

      expect(subject).to eq ["RecommendationTrend Domain"]
    end
  end
end
