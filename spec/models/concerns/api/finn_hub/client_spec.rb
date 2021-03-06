require "rails_helper"

describe Api::FinnHub::Client do
  let!(:conn) { double(:conn) }

  subject(:client) { described_class.new }

  before { allow(Faraday).to receive(:new) { conn } }

  describe "#company_executives" do
    let(:symbol) { "ABC" }

    subject { client.company_executives(symbol) }

    it "expect to get company_executives" do
      expect(client).to receive(:get).with(
        "https://finnhub.io/api/v1/stock/executive?symbol=ABC&token=api_key"
      ) { "Company Executives" }

      expect(subject).to eq "Company Executives"
    end
  end

  describe "#eps_surprises" do
    let(:symbol) { "ABC" }

    subject { client.eps_surprises(symbol) }

    it "expect to get eps_surprises" do
      expect(client).to receive(:get).with(
        "https://finnhub.io/api/v1/stock/earnings?symbol=ABC&token=api_key"
      ) { "Eps Surprises" }

      expect(subject).to eq "Eps Surprises"
    end
  end

  describe "#symbols_by_exchange" do
    let(:exchange) { "ABC" }

    subject { client.symbols_by_exchange(exchange) }

    it "expect to get symbols_by_exchange" do
      expect(client).to receive(:get).with(
        "https://finnhub.io/api/v1/stock/symbol?exchange=ABC&token=api_key"
      ) { "Symbols By Exchange" }

      expect(subject).to eq "Symbols By Exchange"
    end
  end
end
