require "rails_helper"

describe StockStore do
  let(:domain_class) { Entities::Stock }
  subject(:store) { described_class.new }

  describe "#market_movers_by_key_from_cnn" do
    let(:key) { double(:key) }
    let(:symbols) { double(:symbols) }
    subject { store.market_movers_by_key_from_cnn(key) }

    it "expect to call cnn_client and get mover symbols" do
      expect(Allocator).to receive_message_chain(:cnn_client, :market_movers_by_key).with(key) { symbols }

      expect(subject).to eq symbols
    end
  end

  describe "#market_movers_by_key_from_trading_view" do
    let(:key) { double(:key) }
    let(:symbols) { double(:symbols) }
    subject { store.market_movers_by_key_from_trading_view(key) }

    it "expect to call trading_view_client and get mover symbols" do
      expect(Allocator).to receive_message_chain(:trading_view_client, :market_movers_by_key).with(key) { symbols }

      expect(subject).to eq symbols
    end
  end
end
