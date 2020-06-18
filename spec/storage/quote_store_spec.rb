require "rails_helper"

describe QuoteStore do
  let(:cache_key) { "key" }
  let(:domain_class) { Entities::Quote }
  subject(:store) { described_class.new }

  before do
    Rails.cache.clear
    allow_any_instance_of(described_class).to receive(:fetch_cached).with(key: cache_key).and_call_original
  end

  describe "#by_symbol_from_iex" do
    let(:cache_key) { "QuoteStore/by_symbol_from_iex/ABC" }
    let(:quote_response) { double(:quote_response) }
    let(:response) { double(:response, body: {ABC: {quote: quote_response}}) }
    let(:symbol) { "ABC" }

    subject { store.by_symbol_from_iex(symbol) }

    it "expect to call information_by_symbols and build quote" do
      expect(store).to receive_message_chain(
                         :iex_client, :information_by_symbols
                       ).with(symbols: symbol, options: {types: "quote"}) { response }
      expect(domain_class).to receive(:from_iex_response).with(quote_response) { "Quote Domain" }

      expect(subject).to eq "Quote Domain"
    end
  end
end
