require "rails_helper"

describe StockService do
  let(:service) { described_class.new }
  let(:symbol) { double(:symbol) }

  describe "#market_movers_by_key" do
    let(:key) { :losers }
    subject { service.market_movers_by_key(key) }

    context "cnn key" do
      it "expect to call stock_storage and get information from cnn" do
        expect(
          service
        ).to receive_message_chain(:stock_storage, :market_movers_by_key_from_cnn).with(key) { "symbols" }
        expect(service).to receive(:stocks_by_symbols).with(
          symbols: "symbols",
          attrs: described_class::MARKET_MOVER_STOCK_ATTRS
        ) { "stocks" }

        expect(subject).to eq "stocks"
      end
    end

    context "non cnn key" do
      let(:key) { :abc }

      it "expect to call stock_storage and get information from trading_view" do
        expect(
          service
        ).to receive_message_chain(:stock_storage, :market_movers_by_key_from_trading_view).with(key) { "symbols" }
        expect(service).to receive(:stocks_by_symbols).with(
          symbols: "symbols",
          attrs: described_class::MARKET_MOVER_STOCK_ATTRS
        ) { "stocks" }

        expect(subject).to eq "stocks"
      end
    end
  end

  describe "#stock_info_by_symbol" do
    subject { service.stock_info_by_symbol(symbol) }

    it "expect to call stocks_by_symbols with info stock attrs" do
      expect(service).to receive(:stocks_by_symbols).with(
        symbols: symbol,
        attrs: described_class::INFO_STOCK_ATTRS
      ) { ["stock"] }

      expect(subject).to eq "stock"
    end
  end

  describe "#stocks_for_compare" do
    let(:symbols) { double :symbols }
    subject { service.stocks_for_compare(symbols) }

    it "expect to call stocks_by_symbols with info stock attrs" do
      expect(service).to receive(:stocks_by_symbols).with(
        symbols: symbols,
        attrs: described_class::COMPARE_STOCK_ATTRS
      ) { "stocks" }

      expect(subject).to eq "stocks"
    end
  end

  describe "#stocks_for_watch_list" do
    let(:symbols) { double :symbols }
    subject { service.stocks_for_watch_list(symbols) }

    it "expect to call stocks_by_symbols with info stock attrs" do
      expect(service).to receive(:stocks_by_symbols).with(
        symbols: symbols,
        attrs: described_class::WATCH_LIST_STOCK_ATTRS
      ) { "stocks" }

      expect(subject).to eq "stocks"
    end
  end

  describe "#stocks_by_symbols" do
    let(:attrs) { Entities::Stock::ATTRIBUTES }
    let(:company) { build :company, symbol: symbol, external_analysis: "external_analysis" }
    let(:companies) { Array.wrap company }
    let(:symbol) { "AAPL" }
    let(:symbols) { [symbol] }
    subject { service.stocks_by_symbols(symbols: symbols, attrs: attrs) }

    before do
      allow(service).to receive_message_chain(:company_storage, :by_symbols).with(["aapl"]) { companies }
    end

    context "with valid attrs" do
      let(:args) do
        {
          company: company,
          earnings: "Earnings",
          external_analysis: "External Analysis",
          growth: "Growth",
          quote: "Quote",
          news: "News",
          stats: "Stats",
          time_series: "Time Series"
        }
      end

      it "expect to collect the data and build stock" do
        expect(
          service
        ).to receive_message_chain(:earnings_storage, :by_symbol_from_finn_hub).with(symbol) { "Earnings" }
        expect(Entities::ExternalAnalysis).to receive(:from_json).with("external_analysis") { "External Analysis" }
        expect(service).to receive_message_chain(:growth_storage, :by_symbol_from_iex).with(symbol) { "Growth" }
        expect(service).to receive_message_chain(:quote_storage, :by_symbol_from_tradier).with(symbol) { "Quote" }
        expect(service).to receive_message_chain(:news_storage, :by_symbol_from_iex).with(symbol: symbol) { "News" }
        expect(service).to receive_message_chain(:stats_storage, :by_symbol_from_iex).with(symbol) { "Stats" }
        expect(service).to receive(:time_series_by_symbol).with(symbol) { "Time Series" }
        expect(Entities::Stock).to receive(:new).with(args) { "Stock" }

        subject
      end
    end

    context "unknown attr" do
      let(:attrs) { ["abc"] }

      it "expect to raise an error" do
        expect { subject }.to raise_error { |error|
          expect(error).to be_a(StandardError)
          expect(error.message).to eq "Unknown attr: abc for symbol: AAPL"
        }
      end
    end

    context "when symbol does not match any company" do
      let(:companies) { [] }

      it "expect to send the symbol to save and log" do
        expect(CompanyWorker).to receive(:perform_async).with("aapl")
        expect(Rails).to receive_message_chain(:logger, :info).with("Symbol: aapl sent for save.")

        subject
      end
    end
  end

  describe "#time_series_by_symbol" do
    let(:request) { double(:request) }
    subject { service.time_series_by_symbol(symbol) }

    it "expect to call stats_store and get information" do
      expect(TimeSeriesRequest).to receive(:five_year).with(symbol) { request }
      expect(request).to receive(:to_options) { "Options" }
      expect(
        service
      ).to receive_message_chain(:time_series_storage, :by_symbol_from_tradier).with("Options") { "Time Series" }

      expect(subject).to eq "Time Series"
    end
  end
end
