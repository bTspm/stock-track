require "rails_helper"

describe Scraper::WeBullClient do
  let!(:conn) { double(:conn) }
  let(:response) { double(:response, body: body) }
  subject(:client) { described_class.new }

  before do
    allow(Faraday).to receive(:new) { conn }
    allow(client).to receive(:get).with(url) { response }
  end

  describe "#rating_by_company" do
    let(:company) { build :entity_company }
    let(:body) { html_fixture("/external_analyses/we_bull.html") }
    let(:url) { "" }
    subject { client.rating_by_company(company) }

    context "when the exchange is valid" do
      let(:analysis_args) do
        {
          analysts_count: 31,
          original_rating: "Strong Buy",
          price_target: { average: 2417.9, high: 2953.0, low: 2056.0 },
          source: Entities::ExternalAnalyses::Analysis::WE_BULL,
          url: url
        }
      end
      let(:price_target_args) {  }

      before do
        expect(Entities::ExternalAnalyses::Analysis).to receive(:new).with(analysis_args) { "Analysis" }
      end

      context "when company is nasdaq" do
        let(:company) { build :entity_company, :nasdaq }
        let(:url) { "https://www.webull.com/quote/nasdaq-aapl" }

        it { is_expected.to eq "Analysis" }
      end

      context "when company is nyse" do
        let(:company) { build :entity_company, :nyse }
        let(:url) { "https://www.webull.com/quote/nyse-aapl" }

        it { is_expected.to eq "Analysis" }
      end
    end

    context "when the exchange is not valid" do
      it "expect to raise an error" do
        expect { subject }.to raise_error StandardError
      end
    end
  end
end
