require "rails_helper"

describe EarningsStore do
  subject(:store) { described_class.new }

  before do
    Rails.cache.clear
    allow_any_instance_of(described_class).to receive(:fetch_cached).with(key: cache_key).and_call_original
  end

  describe "#eps_estimates_from_finn_hub_by_symbol" do
    let(:cache_key) { "EarningsStore/eps_estimates_from_finn_hub_by_symbol/ABC" }
    let(:domain_class) { Entities::EpsEstimate }
    let(:estimate) { double(:estimate) }
    let(:response) { double(:response, body: { data: [estimate] }) }
    let(:symbol) { "ABC" }

    subject { store.eps_estimates_from_finn_hub_by_symbol(symbol) }

    context "with Premium Data error" do
      it "expect to return empty error" do
        expect(store).to receive_message_chain(
                           :finn_hub_client,
                           :eps_estimates
                         ).with(symbol).and_raise(ApiExceptions::PremiumDataError)
        expect(domain_class).not_to receive(:from_finn_hub_response)

        expect(subject).to eq []
      end
    end

    context "without error" do
      it "expect to get response from finn_hub and build domain entity" do
        expect(store).to receive_message_chain(:finn_hub_client, :eps_estimates).with(symbol) { response }
        expect(domain_class).to receive(:from_finn_hub_response).with(estimate) { "estimate_object" }

        expect(subject).to match_array %w[estimate_object]
      end
    end
  end

  describe "#eps_surprises_from_finn_hub_by_symbol" do
    let(:cache_key) { "EarningsStore/eps_surprises_from_finn_hub_by_symbol/ABC" }
    let(:domain_class) { Entities::EpsSurprise }
    let(:surprise) { double(:surprise) }
    let(:response) { double(:response, body: [surprise]) }
    let(:symbol) { "ABC" }

    subject { store.eps_surprises_from_finn_hub_by_symbol(symbol) }

    it "expect to get response from finn_hub and build domain entity" do
      expect(store).to receive_message_chain(:finn_hub_client, :eps_surprises).with(symbol) { response }
      expect(domain_class).to receive(:from_finn_hub_response).with(surprise) { "surprise_object" }

      expect(subject).to match_array %w[surprise_object]
    end
  end
end
