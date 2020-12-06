require "rails_helper"

describe WatchListService do
  let(:id) { double(:id) }
  let(:service) { described_class.new }
  let(:symbol) { double(:symbol) }

  describe "#add_symbol_to_watch_list" do
    subject { service.add_symbol_to_watch_list(id: id, symbol: symbol) }

    it "expect to call watch_list_storage and add symbol to watchlist" do
      expect(service).to receive_message_chain(:watch_list_storage, :add_symbol_to_watch_list).with(
        id: id,
        symbol: symbol
      ) { "Added" }

      expect(subject).to eq "Added"
    end
  end

  describe "#delete_symbol_from_watch_list" do
    subject { service.delete_symbol_from_watch_list(id: id, symbol: symbol) }

    it "expect to call watch_list_storage and delete symbol to watchlist" do
      expect(service).to receive_message_chain(:watch_list_storage, :delete_symbol_from_watch_list).with(
        id: id,
        symbol: symbol
      ) { "Deleted" }

      expect(subject).to eq "Deleted"
    end
  end

  describe "#delete_watch_list" do
    subject { service.delete_watch_list(id) }

    it "expect to call watch_list_storage and delete" do
      expect(service).to receive_message_chain(:watch_list_storage, :delete).with(id) { "Deleted" }

      expect(subject).to eq "Deleted"
    end
  end

  describe "#save_watch_listte_watch_list" do
    let(:params) { double(:params) }
    subject { service.save_watch_list(params) }

    it "expect to call watch_list_storage and save" do
      expect(service).to receive_message_chain(:watch_list_storage, :save_watch_list).with(params) { "Saved" }

      expect(subject).to eq "Saved"
    end
  end

  describe "#watch_list_by_id" do
    subject { service.watch_list_by_id(id) }

    it "expect to call watch_list_storage and get watch list" do
      expect(service).to receive_message_chain(:watch_list_storage, :by_id).with(id) { "WatchList" }

      expect(subject).to eq "WatchList"
    end
  end

  describe "#user_watch_lists" do
    subject { service.user_watch_lists }

    it "expect to call watch_list_storage and get user watch lists" do
      expect(service).to receive_message_chain(:watch_list_storage, :user_watch_lists) { "User WatchList" }

      expect(subject).to eq "User WatchList"
    end
  end
end
