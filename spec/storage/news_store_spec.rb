require "rails_helper"

describe NewsStore do
  let(:cache_key) { "key" }
  let(:domain_class) { Entities::NewsArticle }
  subject(:store) { described_class.new }

  before do
    Rails.cache.clear
    allow_any_instance_of(described_class).to receive(:fetch_cached).with(key: cache_key).and_call_original
  end

  describe "#by_symbol_from_iex" do
    let(:news_article) { double(:news_article) }
    let(:response) { double(:response, body: [news_article]) }
    let(:stats_response) { double(:stats_response) }
    let(:symbol) { "ABC" }

    before do
      expect(
        store
      ).to receive_message_chain(:iex_client, :news_by_symbol).with(symbol: symbol, count: count) { response }
      expect(domain_class).to receive(:from_iex_response).with(news_article) { "News Domain" }
    end

    context "with count" do
      let(:cache_key) { "NewsStore/by_symbol_from_iex/ABC-20" }
      let(:count) { 20 }
      subject { store.by_symbol_from_iex(symbol: symbol, count: count) }

      it { is_expected.to eq ["News Domain"] }
    end

    context "without count - default" do
      let(:cache_key) { "NewsStore/by_symbol_from_iex/ABC-4" }
      let(:count) { 4 }
      subject { store.by_symbol_from_iex(symbol: symbol) }

      it { is_expected.to eq ["News Domain"] }
    end
  end
end
