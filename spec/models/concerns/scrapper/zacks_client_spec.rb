require "rails_helper"

describe Scraper::ZacksClient do
  let!(:conn) { double(:conn) }
  let(:response) { double(:response, body: body) }
  subject(:client) { described_class.new }

  before do
    allow(Faraday).to receive(:new) { conn }
    expect(client).to receive(:get).with(
      "https://www.zacks.com/stock/quote/#{symbol}/"
    ) { response }
  end

  describe "#rating_by_symbol" do
    let(:symbol) { "AAPL" }
    let(:body) do
      <<-EOS
        <html>
          <head><title>Some Title</title></head>
          <body>
            <p class="rank_view">of Buy</div>
          </body>
        </html>
      EOS
    end
    subject { client.rating_by_symbol(symbol) }

    it "expect to get symbol rating" do
      expect(subject).to eq "Buy"
    end
  end
end
