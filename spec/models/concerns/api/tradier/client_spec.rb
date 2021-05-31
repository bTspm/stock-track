require "rails_helper"

describe Api::Tradier::Client do
  let!(:conn) { double(:conn) }
  subject(:client) { described_class.new }

  before { allow(Faraday).to receive(:new) { conn } }

  describe "#quote_by_symbol" do
    let(:symbol) { "ABC" }

    subject { client.quote_by_symbol(symbol) }

    it "expect to get quote_by_symbol" do
      expect(client).to receive(:get).with(
        "https://sandbox.tradier.com/v1/markets/quotes?symbols=ABC"
      ) { "Quote by Symbol" }

      expect(subject).to eq "Quote by Symbol"
    end

    context "when symbol has period" do
      let(:symbol) { "ABC.D" }

      it "expect to get quote_by_symbol" do
        expect(client).to receive(:get).with(
          "https://sandbox.tradier.com/v1/markets/quotes?symbols=ABC/D"
        ) { "Quote by Symbol" }

        expect(subject).to eq "Quote by Symbol"
      end
    end
  end
end
