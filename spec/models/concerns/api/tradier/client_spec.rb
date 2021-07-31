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

  describe "#time_series" do
    let(:end_datetime) { DateTime.new(2021, 02, 01) }
    let(:start_datetime) { DateTime.new(2021, 01, 01) }
    let(:options) do
      {
        end_datetime: end_datetime,
        interval: "daily",
        start_datetime: start_datetime,
        symbol: "ABC"
      }
    end
    subject { client.time_series(options) }

    context "without start and end datetime" do
      let(:end_datetime) { nil }
      let(:start_datetime) { nil }

      it "expect to get time_series without the end and start date" do
        expect(client).to receive(:get).with(
          "https://sandbox.tradier.com/v1/markets/history?symbol=ABC&interval=daily"
        ) { "Time Series" }

        expect(subject).to eq "Time Series"
      end
    end

    context "with start and end datetime" do
      it "expect to get time_series" do
        expect(client).to receive(:get).with(
          "https://sandbox.tradier.com/v1/markets/history?symbol=ABC&interval=daily&start=2021-01-01&end=2021-02-01"
        ) { "Time Series" }

        expect(subject).to eq "Time Series"
      end
    end
  end
end
