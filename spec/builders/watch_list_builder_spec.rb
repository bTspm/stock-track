require "rails_helper"

describe WatchListBuilder do
  it_behaves_like "BaseBuilder#initialize"
  it_behaves_like "BaseBuilder#build"
  it_behaves_like "BaseBuilder#build_base_entity_from_domain"
  it_behaves_like "BaseBuilder#build_base_entity_from_params"

  let(:db_entity) { OpenStruct.new({ name: "Airlines", symbols: ["ABC"], user_id: 345 }) }
  subject(:builder) { described_class.new(db_entity) }

  describe "#add_symbol" do
    subject { builder.add_symbol("DEF") }

    it "expect to add symbol to symbols list" do
      expect(db_entity.symbols).not_to include "DEF"
      subject

      expect(db_entity.symbols).to include "DEF"
    end
  end

  describe "#delete_symbol" do
    subject { builder.delete_symbol("ABC") }

    it "expect to delete symbol to symbols list" do
      expect(db_entity.symbols).to include "ABC"
      subject

      expect(db_entity.symbols).not_to include "ABC"
    end
  end

  describe "#set_name" do
    subject { builder.set_name("ABC") }

    it "expect to assign name" do
      subject

      expect(db_entity.name).to eq "ABC"
    end
  end

  describe "#set_user_id" do
    subject { builder.set_user_id(123) }

    it "expect to assign user_id" do
      subject

      expect(db_entity.user_id).to eq 123
    end
  end
end
