require "rails_helper"

describe Entities::WatchList do
  it_behaves_like "Entities::BaseEntity#initialize"
  it_behaves_like "Entities::HasDbEntity.from_db_entity"

  let(:args) do
    {
      id: id,
      name: name,
      symbols: symbols
    }
  end
  let(:id) { double(:id) }
  let(:name) { double(:name) }
  let(:symbols) { double(:symbols) }

  describe "#in_list?" do
    let(:symbol) { "AAPL" }
    let(:symbols) { ["AAPL"] }
    subject { described_class.new(args).in_list?(symbol) }

    context "is part of watch list" do
      it { is_expected.to be_truthy }
    end

    context "is not part of watch list" do
      let(:symbol) { "ABC" }
      it { is_expected.to be_falsey }
    end
  end
end
