require "rails_helper"

describe Scraper::TipRanksClient do
  let!(:browser) { double(:browser) }
  subject(:client) { described_class.new }

  before do
    allow(Watir::Browser).to receive(:new) { browser }
    allow(browser).to receive(:goto).with(url) { "Browser Call" }
  end

  describe "#rating_by_symbol" do
    let(:analysis_args) do
      {
        analysts_count: 31,
        original_rating: "Strong Buy",
        price_target: { average: 2417.9, high: 2953.0, low: 2056.0 },
        source: Entities::ExternalAnalyses::Analysis::TIP_RANKS,
        url: "URL"
      }
    end
    let(:class_element) { double(:class_element) }
    let(:html) { html_fixture("/external_analyses/tip_ranks.html") }
    let(:symbol) { double(:symbol) }
    let(:url) { "https://www.tipranks.com/stocks/#{symbol}/forecast" }
    subject { client.rating_by_symbol(symbol) }

    context "when call is successful" do
      it "expect to initialize an analysis" do
        expect(browser).to receive(:element).with(
          class: "client-components-stock-research-analysts-analyst-consensus-style__consensus"
        ) { class_element }
        expect(class_element).to receive(:wait_until)
        expect(browser).to receive(:html) { html }
        expect(Entities::ExternalAnalyses::Analysis).to receive(:new).with(analysis_args) { "Analysis" }
        expect(browser).to receive(:url) { "URL" }
        expect(browser).to receive(:close) { "Closed" }

        expect(subject).to eq "Analysis"
      end
    end

    context "when call is a failure" do
      subject do
        client.rating_by_symbol(symbol)
      rescue StandardError
        "Browser closed after exception"
      end

      it "expect to close the browser when an exception is raised" do
        expect(browser).to receive(:element).and_raise StandardError
        expect(browser).to receive(:close) { "Closed" }

        subject
      end
    end
  end
end
