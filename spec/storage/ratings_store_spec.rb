require "rails_helper"

describe RatingsStore do
  let(:cache_key) { "key" }
  subject(:store) { described_class.new }

  describe "#by_company" do
    let(:company) { build(:entity_company) }
    let(:client) { :zacks_client }
    let(:rating_source) { "Source" }
    subject { store.by_company(company) }

    before do
      stub_const("RatingsStore::SOURCE_AND_CLIENTS_BY_COMPANY", { source: client })
    end

    context "when scraper call is successful" do
      it "expect to build rating" do
        expect(Allocator).to receive_message_chain(:zacks_client, :rating_by_company).with(company) { "Buy" }
        expect(Rails).not_to receive(:logger)
        expect(Entities::Rating).to receive(:new).with({rating: "Buy", source: "source"}) { "Rating" }

        expect(subject).to match_array ["Rating"]
      end
    end

    context "when scraper call fails" do
      let(:exception) { StandardError.new "Test Case" }

      it "expect to log the error and build rating with empty rating" do
        expect(Allocator).to receive_message_chain(:zacks_client, :rating_by_company).with(company).and_raise(exception)
        expect(Rails).to receive_message_chain(:logger, :error).with(
          "Rating failed for client: zacks_client. Symbol: AAPL. Error: Test Case"
        )
        expect(Entities::Rating).to receive(:new).with({rating: "", source: "source"}) { "Rating" }

        expect(subject).to match_array ["Rating"]
      end
    end
  end

  describe "by_symbol" do
    let(:client) { :zacks_client }
    let(:rating_source) { "Source" }
    let(:symbol) { "AAPL" }
    subject { store.by_symbol(symbol) }

    before do
      stub_const("RatingsStore::SOURCES_AND_CLIENTS_BY_SYMBOL", { source: client })
    end

    context "when scraper call is successful" do
      it "expect to build rating" do
        expect(Allocator).to receive_message_chain(:zacks_client, :rating_by_symbol).with(symbol) { "Buy" }
        expect(Rails).not_to receive(:logger)
        expect(Entities::Rating).to receive(:new).with({rating: "Buy", source: "source"}) { "Rating" }

        expect(subject).to match_array ["Rating"]
      end
    end

    context "when scraper call fails" do
      let(:exception) { StandardError.new "Test Case" }

      it "expect to log the error and build rating with empty rating" do
        expect(Allocator).to receive_message_chain(:zacks_client, :rating_by_symbol).with(symbol).and_raise(exception)
        expect(Rails).to receive_message_chain(:logger, :error).with(
          "Rating failed for client: zacks_client. Symbol: AAPL. Error: Test Case"
        )
        expect(Entities::Rating).to receive(:new).with({rating: "", source: "source"}) { "Rating" }

        expect(subject).to match_array ["Rating"]
      end
    end
  end
end
