require "rails_helper"

describe StockService do
  let(:service) { described_class.new }
  let(:symbol) { double(:symbol) }

  describe "#earnings_by_symbol" do
    let(:earnings_store) { double(:earnings_store) }
    subject { service.earnings_by_symbol(symbol).with_indifferent_access }

    it "expect to get eps_estimates & eps_surprises from earnings_store" do
      expect(service).to receive(:earnings_storage).ordered { earnings_store }
      expect(earnings_store).to receive(:eps_estimates_from_finn_hub_by_symbol).with(symbol) { "Estimates" }
      expect(service).to receive(:earnings_storage).ordered { earnings_store }
      expect(earnings_store).to receive(:eps_surprises_from_finn_hub_by_symbol).with(symbol) { "Surprises" }

      expect(subject).to include(eps_estimates: "Estimates", eps_surprises: "Surprises")
    end
  end

  describe "#growth_by_symbol" do
    subject { service.growth_by_symbol(symbol) }

    it "expect to call growth_store and get information" do
      expect(service).to receive_message_chain(:growth_storage, :by_symbol_from_iex).with(symbol) { "Growth" }

      expect(subject).to eq "Growth"
    end
  end

  describe "#market_movers_by_key" do
    let(:key) { :losers }
    subject { service.market_movers_by_key(key) }

    context "cnn key" do
      it "expect to call stock_storage and get information from cnn" do
        expect(service).to receive_message_chain(:stock_storage, :market_movers_by_key_from_cnn).with(key) { "Cnn" }

        expect(subject).to eq "Cnn"
      end
    end

    context "non cnn key" do
      let(:key) { :abc }

      it "expect to call stock_storage and get information from trading_view" do
        expect(service).to receive_message_chain(
                             :stock_storage,
                             :market_movers_by_key_from_trading_view
                           ).with(key) { "Trading View" }

        expect(subject).to eq "Trading View"
      end
    end
  end

  describe "#news_by_symbol" do
    subject { service.news_by_symbol(symbol) }

    it "expect to call news_store and get information" do
      expect(service).to receive_message_chain(:news_storage, :by_symbol_from_iex).with(symbol: symbol) { "News" }

      expect(subject).to eq "News"
    end
  end

  describe "#quote_by_symbol" do
    subject { service.quote_by_symbol(symbol) }

    it "expect to call quote_store and get information" do
      expect(service).to receive_message_chain(:quote_storage, :by_symbol_from_iex).with(symbol) { "quote" }

      expect(subject).to eq "quote"
    end
  end

  describe "#recommendation_trend_by_symbol" do
    subject { service.recommendation_trends_by_symbol(symbol) }

    it "expect to call recommendation_trend_store and get information" do
      expect(service).to receive_message_chain(
                           :recommendation_trend_storage,
                           :by_symbol_from_finn_hub).with(symbol) { "recommendation_trend" }

      expect(subject).to eq "recommendation_trend"
    end
  end

  describe "#save_exchanges" do
    subject { service.save_exchanges }

    it "expect to call exchange_store and save_exchanges" do
      expect(service).to receive_message_chain(:exchange_storage, :save_exchanges) { "Created/Updated" }

      expect(subject).to eq "Created/Updated"
    end
  end

  describe "#stats_by_symbol" do
    subject { service.stats_by_symbol(symbol) }

    it "expect to call stats_store and get information" do
      expect(service).to receive_message_chain(:stats_storage, :by_symbol_from_iex).with(symbol) { "stats" }

      expect(subject).to eq "stats"
    end
  end

  describe "#stocks_by_symbols" do
    subject { service.stocks_by_symbols([symbol]) }

    it "expect to call stock_store and get information" do
      expect(service).to receive_message_chain(:stock_storage, :by_symbols).with([symbol]) { "stocks" }

      expect(subject).to eq "stocks"
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
      ).to receive_message_chain(:time_series_storage, :by_symbol_from_twelve_data).with("Options") { "Time Series" }

      expect(subject).to eq "Time Series"
    end
  end
end
