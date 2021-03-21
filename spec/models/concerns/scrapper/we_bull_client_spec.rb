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
    let(:body) do
      <<-EOS
        <html>
          <head><title>Some Title</title></head>
          <body>
            <div class="jss19ghvuu">Buy</div>
          </body>
        </html>
      EOS
    end
    let(:url) { "" }
    subject { client.rating_by_company(company) }

    context "when company is nasdaq" do
      let(:company) { build :entity_company, :nasdaq }
      let(:url) { "https://www.webull.com/quote/nasdaq-aapl" }

      it { is_expected.to eq "Buy" }
    end

    context "when company is nyse" do
      let(:company) { build :entity_company, :nyse }
      let(:url) { "https://www.webull.com/quote/nyse-aapl" }

      it { is_expected.to eq "Buy" }
    end

    context "when company is neither nyse nor nasdaq" do
      it "expect to raise an error" do
        expect{ subject }.to raise_error StandardError
      end
    end
  end
end
