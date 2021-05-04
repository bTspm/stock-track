require "rails_helper"

describe Scraper::BarChartClient do
  let!(:conn) { double(:conn) }
  let(:response) { double(:response, body: body) }
  subject(:client) { described_class.new }

  before do
    allow(Faraday).to receive(:new) { conn }
    expect(client).to receive(:get).with(url) { response }
  end

  describe "#analysis_by_symbol" do
    let(:symbol) { "AAPL" }
    let(:url) { "https://www.barchart.com/stocks/quotes/#{symbol}/analyst-ratings" }
    let(:analysis_args) do
      {
        analysts_count: 31,
        original_rating: "Strong Buy",
        source: Entities::ExternalAnalyses::Analysis::BAR_CHART,
        url: url
      }
    end
    let(:body) { html_fixture("/external_analyses/bar_chart.html") }
    subject { client.analysis_by_symbol(symbol) }

    it "expect to init analysis" do
      expect(Entities::ExternalAnalyses::Analysis).to receive(:new).with(analysis_args) { "Analysis" }

      expect(subject).to eq "Analysis"
    end
  end
end
