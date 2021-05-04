require "rails_helper"

describe Scraper::CnnClient do
  let!(:conn) { double(:conn) }
  let(:response) { double(:response, body: body) }
  subject(:client) { described_class.new }

  before do
    allow(Faraday).to receive(:new) { conn }
    expect(client).to receive(:get).with(url) { response }
  end

  describe "#analysis_by_symbol" do
    let(:symbol) { "AAPL" }
    let(:url) { "https://money.cnn.com/quote/forecast/forecast.html?symb=AAPL" }
    let(:analysis_args) do
      {
        analysts_count: 31,
        original_rating: "Strong Buy",
        price_target: { average: 2417.9, high: 2953.0, low: 2056.0 },
        source: Entities::ExternalAnalyses::Analysis::CNN,
        url: url
      }
    end
    let(:body) { html_fixture("/external_analyses/cnn.html") }
    subject { client.analysis_by_symbol(symbol) }

    before { expect(Entities::ExternalAnalyses::Analysis).to receive(:new).with(analysis_args) { "Analysis" } }

    context "when symbol has period" do
      let(:symbol) { "AAP.L" }

      it { is_expected.to eq "Analysis" }
    end

    context "when symbol does not have period" do
      it { is_expected.to eq "Analysis" }
    end
  end

  describe "#market_movers_by_key" do
    let(:body) do
      <<-EOS
        <html>
          <head><title>Some Title</title></head>
          <body>
            <div class="wsod_dataTable"><a class="wsod_symbol">active_symbol</a></div>
            <div class="wsod_dataTable"><a class="wsod_symbol">gainers_symbol</a></div>
            <div class="wsod_dataTable"><a class="wsod_symbol">losers_symbol</a></div>
          </body>
        </html>
      EOS
    end
    let(:url) { "https://money.cnn.com/data/hotstocks/" }
    subject { client.market_movers_by_key(key) }
    
    context "active" do
      let(:key) { :active }
      
      it { is_expected.to match_array ["active_symbol"] }
    end

    context "gainers" do
      let(:key) { :gainers }

      it { is_expected.to match_array ["gainers_symbol"] }
    end

    context "gainers" do
      let(:key) { :gainers }

      it { is_expected.to match_array ["gainers_symbol"] }
    end
  end
end
