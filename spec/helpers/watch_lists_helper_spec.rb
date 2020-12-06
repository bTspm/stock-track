require "rails_helper"
require "clearance/rspec"

describe WatchListsHelper do
  describe "#add_watch_list_title" do
    subject { helper.add_watch_list_title }

    it "expect to return title" do
      expect(helper).to receive(:fontawesome_icon).with(
        name_icon_with_style: "fas fa-plus",
        text: "Add Watch List"
      ) { "Title" }

      expect(subject).to eq "Title"
    end
  end

  describe "#symbol_delete_button" do
    let(:symbol) { "AAPL.A" }
    let(:watch_list_id) { 123 }
    subject { helper.symbol_delete_button(watch_list_id: watch_list_id, symbol: symbol) }

    it "expect to return delete button" do
      result = subject

      expect(result).to have_css ".text-danger"
      expect(result).to have_css ".symbol-delete"
      expect(result).to include "Delete from Watch List"
      expect(result).to include "AAPL0A-123"
      expect(result).to include "/watch_lists/123/delete_symbol?symbol=AAPL.A"
    end
  end

  describe "#watch_list_information" do
    let(:watch_list_id) { 123 }
    subject { helper.watch_list_information(watch_list_id) }

    context "with watch_list_id" do
      it "expect to render loading card" do
        expect(helper).to receive(:render_async).with(watch_list_path(id: watch_list_id)) { "Rendered" }

        subject
      end
    end

    context "without watch_list_id" do
      let(:watch_list_id) { nil }
      it { is_expected.to include "No Watch Lists, please add." }
    end
  end

  describe "#watch_lists_popover_content" do
    let(:watch_list) { build(:entity_watch_list) }
    let(:watch_lists) { WatchListsPresenter.present([watch_list], view_context) }
    subject { helper.watch_lists_popover_content(watch_lists) }

    context "with watch_lists" do
      before do
        controller.params[:symbol] = "AAPL"
        expect(watch_list).to receive(:in_list?).with("AAPL") { in_list_flag }
      end

      context "in list - true" do
        let(:in_list_flag) { true }
        it { is_expected.to include "symbol-delete"  }
      end

      context "in list - false" do
        let(:in_list_flag) { false }
        it { is_expected.to include "symbol-add"  }
      end
    end

    context "without watch_lists" do
      let(:watch_lists) { [] }
      it { is_expected.to include "No watchlists found, please create." }
    end
  end

  describe "#watch_list_delete_edit_buttons" do
    let(:watch_list_id) { 123 }
    subject { helper.watch_list_delete_edit_buttons(watch_list_id) }

    it "expect to include edit and delete buttons" do
      expect(subject).to include "Edit Watch List"
      expect(subject).to include "watch-list-delete-button"
      expect(subject).to include "Delete Watch List"
      expect(subject).to include "watch-list-edit-button"
      expect(subject).to include "123"
    end
  end

  describe "#add_symbol_to_watch_list_button" do
    subject { helper.add_symbol_to_watch_list_button }
    
    context "guest user" do
      it "expect to include to login to user" do
        expect(subject).to include "Login to add to watchlist"
        expect(subject).to include "add-to-watch-list-popover-for-guest"
      end
    end

    context "signed in user" do
      it "expect to include to login to user" do
        sign_in

        expect(subject).not_to include "Login to add to watchlist"
        expect(subject).to include "add-to-watch-list-popover"
      end
    end
  end
end
