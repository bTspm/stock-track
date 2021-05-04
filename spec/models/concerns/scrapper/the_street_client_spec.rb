require "rails_helper"

describe Scraper::TheStreetClient do
  let!(:conn) { double(:conn) }
  let(:response) { double(:response, body: body) }
  subject(:client) { described_class.new }

  describe "#analysis_by_symbol" do
    let(:analysis_args) do
      {
        custom: custom_args,
        original_rating: "A(Buy)",
        source: Entities::ExternalAnalyses::Analysis::THE_STREET,
        url: url_rating
      }
    end
    let(:custom_args) do
      {
        growth: 5.0,
        total_return: 3.0,
        efficiency: 5.0,
        price_volatility: 5.0,
        solvency: 3.5,
        income: 3.5
      }.with_indifferent_access
    end
    let(:body_rating) { html_fixture("/external_analyses/the_street/rating.html") }
    let(:body_summary) { html_fixture("/external_analyses/the_street/summary.html") }
    let(:response_rating) { double(:response_rating, body: body_rating) }
    let(:response_summary) { double(:response_summary, body: body_summary) }
    let(:result) { double(:result) }
    let(:symbol) { double(:symbol) }
    let(:url_rating) { "https://www.thestreet.com/r/ratings/reports/summary/#{symbol}.html" }
    let(:url_summary) { "https://www.thestreet.com/r/ratings/reports/detail/#{symbol}.html" }
    subject { client.analysis_by_symbol(symbol) }

    before do
      allow(Faraday).to receive(:new) { conn }
      expect(client).to receive(:get).with(url_rating) { response_rating }
      expect(client).to receive(:get).with(url_summary) { response_summary }
    end

    it "expect to init analysis" do
      expect(Entities::ExternalAnalyses::Analysis).to receive(:new).with(analysis_args) { "Analysis" }

      expect(subject).to eq "Analysis"
    end
  end
end
