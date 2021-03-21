require "rails_helper"

describe Scraper::NasdaqClient do
  let!(:browser) { double(:browser) }
  let(:response) { double(:response, body: body) }
  subject(:client) { described_class.new }

  before do
    allow(Watir::Browser).to receive(:new) { browser }
    allow(browser).to receive(:goto).with(url) { "Browser Call" }
  end

  describe "#rating_by_symbol" do
    let(:class_element) { double(:class_element) }
    let(:span_element) { double(:p_element, text: "Buy") }
    let(:span_elements) { [span_element] }
    let(:result) { double(:result) }
    let(:symbol) { double(:symbol) }
    let(:url) { "https://www.nasdaq.com/market-activity/stocks/#{symbol}/analyst-research" }
    subject { client.rating_by_symbol(symbol) }

    context "when call is successful" do
      it "expect to return rating" do
        expect(browser).to receive(:element).with(class: "upgrade-downgrade-b__summary") { class_element }
        expect(class_element).to receive(:wait_until) { result }
        expect(result).to receive(:elements).with(css: "span") { span_elements }
        expect(browser).to receive(:close) { "Closed" }

        expect(subject).to eq "Buy"
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
