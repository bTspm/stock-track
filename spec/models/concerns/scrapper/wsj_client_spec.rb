require "rails_helper"

describe Scraper::WsjClient do
  let!(:conn) { double(:conn) }
  let(:response) { double(:response, body: body) }
  subject(:client) { described_class.new }

  before do
    allow(Faraday).to receive(:new) { conn }
    expect(client).to receive(:get).with(url) { response }
  end

  describe "#analysis_by_symbol" do
    let(:symbol) { "AAPL" }
    let(:url) { "https://www.wsj.com/market-data/quotes/AAPL/research-ratings" }
    let(:analysis_args) do
      {
        analysts_count: 31,
        original_rating: "Strong Buy",
        price_target: { average: 2417.9, high: 2953.0, low: 2056.0 },
        source: Entities::ExternalAnalyses::Analysis::WSJ,
        url: url
      }
    end
    let(:body) { html_fixture("/external_analyses/wsj.html") }
    subject { client.analysis_by_symbol(symbol) }

    it "expect to init analysis" do
      expect(Entities::ExternalAnalyses::Analysis).to receive(:new).with(analysis_args) { "Analysis" }

      expect(subject).to eq "Analysis"
    end
  end
end
