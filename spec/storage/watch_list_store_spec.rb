require "rails_helper"

describe WatchListStore do
  let(:cache_key) { "cache" }
  let(:symbol) { "AAPL" }
  let(:user) { create(:user) }
  let(:watch_list) { create(:watch_list, user: user) }
  let(:watch_list_builder) { double(:watch_list_builder) }
  subject(:store) { described_class.new(user) }

  describe "#add_symbol_to_watch_list" do
    subject { store.add_symbol_to_watch_list(id: watch_list.id, symbol: symbol) }

    it "expect to retrieve watch_list and add symbol" do
      expect(WatchList).to receive(:find_by!).with(id: watch_list.id, user_id: user.id).and_call_original
      expect(WatchListBuilder).to receive(:new).with(watch_list) { watch_list_builder }
      expect(watch_list_builder).to receive(:build).and_yield(watch_list_builder)
      expect(watch_list_builder).to receive(:add_symbol).with(symbol) { watch_list }
      expect(watch_list).to receive(:save!) { watch_list }
      expect(Entities::WatchList).to receive(:from_db_entity).with(watch_list) { "Watch List" }

      expect(subject).to eq "Watch List"
    end
  end

  describe "#by_id" do
    subject { store.by_id(watch_list.id) }

    it "expect to retrieve watch_list" do
      expect(WatchList).to receive(:find_by!).with(id: watch_list.id, user_id: user.id).and_call_original
      expect(Entities::WatchList).to receive(:from_db_entity).with(watch_list) { "Watch List" }

      subject
    end
  end


  describe "#delete" do
    subject { store.delete(watch_list.id) }

    it "expect to delete watch list" do
      subject

      expect(WatchList.where(id: watch_list.id).blank?).to be_truthy
    end
  end

  describe "#delete_symbol_from_watch_list" do
    subject { store.delete_symbol_from_watch_list(id: watch_list.id, symbol: symbol) }

    it "expect to retrieve watch_list and delete symbol" do
      expect(WatchList).to receive(:find_by!).with(id: watch_list.id, user_id: user.id).and_call_original
      expect(WatchListBuilder).to receive(:new).with(watch_list) { watch_list_builder }
      expect(watch_list_builder).to receive(:build).and_yield(watch_list_builder)
      expect(watch_list_builder).to receive(:delete_symbol).with(symbol) { watch_list }
      expect(watch_list).to receive(:save!) { watch_list }
      expect(Entities::WatchList).to receive(:from_db_entity).with(watch_list) { "Watch List" }

      expect(subject).to eq "Watch List"
    end
  end

  describe "#save_watch_list" do
    let(:params) { { id: watch_list.id, symbols: watch_list.symbols } }
    let(:watch_list_builder) { double(:watch_list_builder) }
    subject { store.save_watch_list(params) }

    before do
      expect(WatchList).to receive(:find_by!).with(id: params[:id], user_id: user.id) { watch_list }
      expect(WatchListBuilder).to receive(:new).with(watch_list) { watch_list_builder }
      expect(watch_list_builder).to receive(:build_base_entity_from_params).with(params) { watch_list }
      expect(Entities::WatchList).to receive(:from_db_entity).with(watch_list) { "WatchList" }
    end

    context "save successful" do
      it "expect to save watch_list and return domain entity" do
        expect(watch_list).to receive(:save!) { "Saved" }

        subject
      end
    end

    context "save unsuccessful" do
      it "expect to log and raise an error" do
        expect(watch_list).to receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(watch_list))
        expect(Rails).to receive_message_chain(:logger, :error).with(
          "Watchlist save failed: #{watch_list.id}, Airlines with errors: Validation failed: "
        ) { "Error Logged" }

        expect { subject }.to raise_error AppExceptions::RecordInvalid
      end
    end
  end

  describe "#user_watch_lists" do
    subject { store.user_watch_lists }

    it "expect to retrieve user watch lists" do
      expect(Entities::WatchList).to receive(:from_db_entity).with(watch_list) { "Watch List" }

      expect(subject).to eq ["Watch List"]
    end
  end
end
