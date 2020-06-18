require "rails_helper"

describe CompanyExecutiveStore do
  let(:domain_class) { Entities::CompanyExecutive }
  subject(:store) { described_class.new }

  before do
    Rails.cache.clear
    allow_any_instance_of(described_class).to receive(:fetch_cached).with(key: cache_key).and_call_original
  end

  describe "#by_symbol_from_finn_hub" do
    let(:cache_key) { "CompanyExecutiveStore/by_symbol_from_finn_hub/ABC" }
    let(:executive_response) { double(:executive_response) }
    let(:response) { double(:response, body: { executive: [executive_response] }) }
    let(:symbol) { "ABC" }

    subject { store.by_symbol_from_finn_hub(symbol) }

    it "expect to get response from finn_hub and build domain entity" do
      expect(store).to receive_message_chain(:finn_hub_client, :company_executives).with(symbol) { response }
      expect(domain_class).to receive(:from_finn_hub_response).with(executive_response) { "executive_object" }

      expect(subject).to match_array %w[executive_object]
    end
  end
end
