require "rails_helper"

describe StatsStore do
  let(:cache_key) { "key" }
  let(:domain_class) { Entities::Stats }
  subject(:store) { described_class.new }

  before do
    Rails.cache.clear
    allow_any_instance_of(described_class).to receive(:fetch_cached).with(key: cache_key).and_call_original
  end

  describe "#by_symbol_from_iex" do
    let(:cache_key) { "StatsStore/by_symbol_from_iex/ABC" }
    let(:response) { double(:response, body: {ABC: {stats: stats_response}}) }
    let(:stats_response) { double(:stats_response) }
    let(:symbol) { "ABC" }

    subject { store.by_symbol_from_iex(symbol) }

    it "expect to call information_by_symbols and build growth" do
      expect(Allocator).to receive_message_chain(
                         :iex_client, :information_by_symbols
                       ).with(symbols: symbol, options: {types: "stats"}) { response }
      expect(domain_class).to receive(:from_iex_response).with(stats_response) { "Stats Domain" }

      expect(subject).to eq "Stats Domain"
    end
  end
end
