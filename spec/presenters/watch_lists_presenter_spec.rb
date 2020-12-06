require "rails_helper"

describe WatchListsPresenter do
  describe ".scalar" do
    let(:id) { double(:id) }
    let(:name) { double(:name) }
    let(:object) { double(:object, id: id, name: name) }
    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#for_select" do
      subject { presenter.for_select }

      it "expect to return array" do
        expect(view_context).to receive(:watch_list_path).with(id: id) { "Link" }

        expect(subject).to eq [name, id, {"data-watch-list-path": "Link"}]
      end
    end
  end

  describe ".enum" do
    let(:created_at1) { Date.today - 5.days }
    let(:id1) { 123 }
    let(:name1) { "ABC" }
    let(:object1) { double(:object1, created_at: created_at1, id: id1, name: name1) }
    let(:created_at2) { Date.today + 5.days }
    let(:id2) { 999 }
    let(:name2) { "XYZ" }
    let(:object2) { double(:object2, created_at: created_at2, id: id2, name: name2) }
    let(:objects) { [object1, object2] }
    subject(:presenter) { described_class::Enum.new(objects, view_context) }

    describe "#for_select" do
      subject { presenter.for_select }

      it "expect to initialize a watch list entity" do
        expect(presenter).to receive(:_ordered_by_created_at_asc) { objects }
        expect(object1).to receive(:for_select) { "For Object1 select" }
        expect(object2).to receive(:for_select) { "For Object2 select" }

        expect(subject).to eq ["For Object1 select", "For Object2 select"]
      end
    end

    describe "#new_watch_list" do
      subject { presenter.new_watch_list }

      it "expect to initialize a watch list entity" do
        expect(Entities::WatchList).to receive(:new) { "Initialized" }

        expect(subject).to eq "Initialized"
      end
    end

    describe "#ordered_by_name_asc" do
      subject { presenter.ordered_by_name_asc.map(&:name) }

      it "expect to return watch lists ordered by name" do
        expect(subject).to eq ["ABC", "XYZ"]
      end
    end

    describe "#selected_watch_list_id" do
      subject { presenter.selected_watch_list_id }

      it "expect to return watch lists ordered by created_at" do
        expect(subject).to eq 123
      end
    end
  end
end
