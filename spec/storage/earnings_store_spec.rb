require "rails_helper"

describe EarningsStore do
  subject(:store) { described_class.new }

  before do
    Rails.cache.clear
    allow_any_instance_of(described_class).to receive(:fetch_cached).with(key: cache_key).and_call_original
  end

  describe "#by_symbol_from_finn_hub" do
    let(:cache_key) { "EarningsStore/by_symbol_from_finn_hub/ABC" }
    let(:domain_class) { Entities::EpsSurprise }
    let(:surprise) { double(:surprise) }
    let(:response) { double(:response, body: [surprise]) }
    let(:symbol) { "ABC" }

    subject { store.by_symbol_from_finn_hub(symbol) }

    it "expect to get response from finn_hub and build domain entity" do
      expect(Allocator).to receive_message_chain(:finn_hub_client, :eps_surprises).with(symbol) { response }
      expect(domain_class).to receive(:from_finn_hub_response).with(surprise) { "surprise_object" }

      expect(subject).to match_array %w[surprise_object]
    end
  end
end
