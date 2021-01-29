require "rails_helper"

describe StockStore do
  let(:domain_class) { Entities::Stock }
  subject(:store) { described_class.new }

  describe "#by_symbols" do
    let(:args) do
      {
        company: company,
        growth: "Growth",
        quote: "Quote",
        stats: "Stats"
      }
    end
    let(:companies) { [company] }
    let(:company) { build(:company) }
    let(:symbols) { Array.wrap(symbol) }
    let(:symbol) { company.symbol }
    subject { store.by_symbols(symbols) }

    before do
      expect(CompanyStore).to receive_message_chain(:new, :by_symbols).with(symbols) { companies }
    end

    context "without companies" do
      let(:companies) { [] }
      it { is_expected.to match_array [] }

      it "expect to schedule a background job to save company with symbol" do
        expect(CompanyWorker).to receive(:perform_async).with(symbol) { "Scheduled" }
        expect(Rails).to receive_message_chain(:logger, :info).with("Symbol: AAPL sent for save.") { "Logged" }

        subject
      end
    end

    context "with companies" do
      it "expected to get stock with company, growth, quote and stats" do
        expect(GrowthStore).to receive_message_chain(:new, :by_symbol_from_iex).with(symbol) { "Growth" }
        expect(QuoteStore).to receive_message_chain(:new, :by_symbol_from_iex).with(symbol) { "Quote" }
        expect(StatsStore).to receive_message_chain(:new, :by_symbol_from_iex).with(symbol) { "Stats" }
        expect(Entities::Stock).to receive(:new).with(args) { "Stock" }

        expect(subject).to match_array ["Stock"]
      end
    end
  end

  describe "#market_movers_by_key_from_cnn" do
    let(:key) { double(:key) }
    let(:symbols) { double(:symbols) }
    subject { store.market_movers_by_key_from_cnn(key) }

    it "expect to call cnn_client and get mover symbols" do
      expect(Allocator).to receive_message_chain(:cnn_client, :market_movers_by_key).with(key) { symbols }
      expect(store).to receive(:by_symbols).with(symbols) { "Stocks" }

      expect(subject).to eq "Stocks"
    end
  end

  describe "#market_movers_by_key_from_trading_view" do
    let(:key) { double(:key) }
    let(:symbols) { double(:symbols) }
    subject { store.market_movers_by_key_from_trading_view(key) }

    it "expect to call trading_view_client and get mover symbols" do
      expect(Allocator).to receive_message_chain(:trading_view_client, :market_movers_by_key).with(key) { symbols }
      expect(store).to receive(:by_symbols).with(symbols) { "Stocks" }

      expect(subject).to eq "Stocks"
    end
  end
end
