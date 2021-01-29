require "rails_helper"

describe Scraper::CnnClient do
  let!(:conn) { double(:conn) }
  let(:response) { double(:response, body: body) }
  subject(:client) { described_class.new }

  before do
    allow(Faraday).to receive(:new) { conn }
    expect(client).to receive(:get).with("https://money.cnn.com/data/hotstocks/") { response }
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
