require "rails_helper"

describe Scraper::BarChartClient do
  let!(:conn) { double(:conn) }
  let(:response) { double(:response, body: body) }
  subject(:client) { described_class.new }

  before do
    allow(Faraday).to receive(:new) { conn }
    allow(client).to receive(:get).with(url) { response }
  end

  describe "#rating_by_symbol" do
    let(:symbol) { double(:symbol) }
    let(:body) do
      <<-EOS
        <html>
          <head><title>Some Title</title></head>
          <body>
            <div class="opinion-status">
              <span>Buy</span>
              <span>90</span>
            </div>
          </body>
        </html>
      EOS
    end
    let(:url) { "https://www.barchart.com/stocks/quotes/#{symbol}/opinion" }
    subject { client.rating_by_symbol(symbol) }

    it { is_expected.to eq "Buy 90" }
  end
end
