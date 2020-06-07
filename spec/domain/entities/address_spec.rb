require "rails_helper"

describe Entities::Address do
  it_behaves_like "Entities::BaseEntity#initialize"
  it_behaves_like "Entities::DbEntity.from_db_entity"

  let(:args) do
    {
      city: city,
      country: country,
      id: id,
      line_1: line_1,
      line_2: line_2,
      state: state,
      zip_code: zip_code
    }
  end
  let(:city) { double(:city) }
  let(:country) { double(:country) }
  let(:id) { double(:id) }
  let(:line_1) { double(:line_1) }
  let(:line_2) { double(:line_2) }
  let(:state) { double(:state) }
  let(:zip_code) { double(:zip_code) }

  describe ".from_iex_response" do
    let(:args) do
      {
        line_1: "One Apple Park Way",
        line_2: "Address 2",
        city: "Cupertino",
        country: "US",
        state: "CA",
        zip_code: "95014-2083"
      }
    end
    let!(:response) { json_fixture("/api_responses/iex/company.json") }

    subject { described_class.from_iex_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
