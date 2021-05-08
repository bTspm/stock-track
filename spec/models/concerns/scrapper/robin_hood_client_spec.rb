require "rails_helper"

describe Scraper::RobinHoodClient do
  let!(:conn) { double(:conn) }
  let(:response) { double(:response, body: body) }
  subject(:client) { described_class.new }

  before do
    allow(Faraday).to receive(:new) { conn }
    expect(client).to receive(:get).with(url) { response }
  end

  describe "#analysis_by_symbol" do
    let(:symbol) { "AAPL" }
    let(:url) { "https://robinhood.com/stocks/#{symbol}" }
    let(:analysis_args) do
      {
        analysts_count: 31,
        original_rating: original_rating,
        source: Entities::ExternalAnalyses::Analysis::ROBIN_HOOD,
        url: url
      }
    end
    let(:original_rating) { "" }
    let(:body) { html_fixture("/external_analyses/robin_hood.html") }
    subject { client.analysis_by_symbol(symbol) }

    before { expect(Entities::ExternalAnalyses::Analysis).to receive(:new).with(analysis_args) { "Analysis" } }

    context "when the percentage for buy is high" do
      let(:body) { html_fixture("/external_analyses/robin_hood/buy.html") }
      let(:original_rating) { "Buy" }

      it { is_expected.to eq "Analysis" }
    end

    context "when the percentage for hold is high" do
      let(:body) { html_fixture("/external_analyses/robin_hood/hold.html") }
      let(:original_rating) { "Hold" }

      it { is_expected.to eq "Analysis" }
    end

    context "when the percentage for sell is high" do
      let(:body) { html_fixture("/external_analyses/robin_hood/sell.html") }
      let(:original_rating) { "Sell" }

      it { is_expected.to eq "Analysis" }
    end

    context "when the percentage for buy and hold is same" do
      let(:body) { html_fixture("/external_analyses/robin_hood/buy_and_hold_same.html") }
      let(:original_rating) { "Buy" }

      it { is_expected.to eq "Analysis" }
    end

    context "when the percentage for buy and sell is same" do
      let(:body) { html_fixture("/external_analyses/robin_hood/buy_and_sell_same.html") }
      let(:original_rating) { "Buy" }

      it { is_expected.to eq "Analysis" }
    end

    context "when the percentage for hold and sell is same" do
      let(:body) { html_fixture("/external_analyses/robin_hood/hold_and_sell_same.html") }
      let(:original_rating) { "Hold" }

      it { is_expected.to eq "Analysis" }
    end

    context "when the percentage for buy, hold and sell is same" do
      let(:body) { html_fixture("/external_analyses/robin_hood/buy_hold_sell_same.html") }
      let(:original_rating) { "Buy" }

      it { is_expected.to eq "Analysis" }
    end
  end
end
