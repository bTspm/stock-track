require "rails_helper"

describe Scraper::ZacksClient do
  let!(:conn) { double(:conn) }
  let(:response) { double(:response, body: body) }
  subject(:client) { described_class.new }

  before do
    allow(Faraday).to receive(:new) { conn }
    expect(client).to receive(:get).with(url) { response }
  end

  describe "#analysis_by_symbol" do
    let(:symbol) { "AAPL" }
    let(:url) { "https://www.zacks.com/stock/quote/#{symbol}/" }
    subject { client.analysis_by_symbol(symbol) }

    context "when rating is available" do
      let(:analysis_args) do
        {
          custom: { growth: "A", momentum: "F", value: "C", vgm: "C" }.with_indifferent_access,
          original_rating: "Strong Buy",
          source: Entities::ExternalAnalyses::Analysis::ZACKS,
          url: url
        }
      end
      let(:body) { html_fixture("/external_analyses/zacks/with_rating.html") }

      it "expect to init analysis" do
        expect(Entities::ExternalAnalyses::Analysis).to receive(:new).with(analysis_args) { "Analysis" }

        expect(subject).to eq "Analysis"
      end
    end

    context "when rating is not available" do
      let(:analysis_args) do
        {
          custom: nil,
          original_rating: "",
          source: Entities::ExternalAnalyses::Analysis::ZACKS,
          url: url
        }
      end
      let(:body) { html_fixture("/external_analyses/zacks/without_rating.html") }

      it "expect to init empty analysis" do
        expect(Entities::ExternalAnalyses::Analysis).to receive(:new).with(analysis_args) { "Analysis" }

        expect(subject).to eq "Analysis"
      end
    end
  end
end
