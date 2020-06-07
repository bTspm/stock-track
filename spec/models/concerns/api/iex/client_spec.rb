require "rails_helper"

describe Api::Iex::Client do
  let!(:conn) { double(:conn) }

  subject(:client) { described_class.new }

  before { allow(Faraday).to receive(:new) { conn } }

  describe "#exchanges" do
    subject { client.exchanges }

    it "expect to get exchanges" do
      expect(client).to receive(:get).with(
       "https://cloud.iexapis.com/stable/ref-data/exchanges?token=api_key"
      ) { "Exchanges" }

      expect(subject).to eq "Exchanges"
    end
  end

  describe "#information_by_symbols" do
    let(:options) { {types: types} }
    let(:symbols) { "ABC" }
    let(:types) { "Types" }

    subject { client.information_by_symbols(symbols: symbols, options: options) }

    it "expect to get information_by_symbols" do
      expect(client).to receive(:get).with(
       "https://cloud.iexapis.com/v1/stock/market/batch?token=api_key&symbols=ABC&types=Types"
      ) { "Information by Symbols" }

      expect(subject).to eq "Information by Symbols"
    end
  end

  describe "#news_by_symbol" do
    let(:count) { 500 }
    let(:symbol) { "ABC" }
    let(:types) { "Types" }

    subject { client.news_by_symbol(symbol: symbol, count: count) }

    context "without count" do
      subject { client.news_by_symbol(symbol: symbol) }

      it "expect to get information_by_symbols" do
        expect(client).to receive(:get).with(
         "https://cloud.iexapis.com/v1/stock/ABC/news/last/4?token=api_key"
        ) { "News by Symbol" }

        expect(subject).to eq "News by Symbol"
      end
    end

    context "with count" do
      it "expect to get information_by_symbols" do
        expect(client).to receive(:get).with(
         "https://cloud.iexapis.com/v1/stock/ABC/news/last/500?token=api_key"
        ) { "News by Symbol" }

        expect(subject).to eq "News by Symbol"
      end
    end
  end
end
