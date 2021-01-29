require "rails_helper"

describe Scraper::TradingViewClient do
  let!(:conn) { double(:conn) }
  let(:response) { double(:response, body: body) }
  subject(:client) { described_class.new }

  before do
    allow(Faraday).to receive(:new) { conn }
    expect(client).to receive(:get).with(
      "https://www.tradingview.com/markets/stocks-usa/market-movers-#{key}/"
    ) { response }
  end

  describe "#market_movers_by_key" do
    let(:key) { :gainers }
    let(:body) do
      <<-EOS
        <html>
          <head><title>Some Title</title></head>
          <body>
            <div class="tv-screener__symbol">ABC</div>
            <div class="tv-screener__symbol">DEF</div>
          </body>
        </html>
      EOS
    end
    subject { client.market_movers_by_key(key) }

    it "expect to get market_movers_by_key" do
      expect(subject).to match_array ["ABC", "DEF"]
    end

    context "retrieve only limit symbols" do
      let(:body) do
        <<-EOS
        <html>
          <head><title>Some Title</title></head>
          <body> #{symbols} </body>
        </html>
        EOS
      end
      let(:symbols) do
        ("a".."z").map { |character| %{<div class="tv-screener__symbol">#{character}</div>} }.join(" ")
      end
      subject { client.market_movers_by_key(key).count }

      it { is_expected.to eq 10 }
    end

    context "retrieve only symbols with less or equal to 5 characters" do
      let(:body) do
        <<-EOS
        <html>
          <head><title>Some Title</title></head>
          <body> 
            <div class="tv-screener__symbol">ABCEFG</div> 
            <div class="tv-screener__symbol">ABCDE</div> 
            <div class="tv-screener__symbol">ABCD</div> 
          </body>
        </html>
        EOS
      end

      it { is_expected.to match_array ["ABCDE", "ABCD"] }
    end
  end
end
