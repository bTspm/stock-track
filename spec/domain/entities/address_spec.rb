require "rails_helper"

describe Entities::Address do
  it_behaves_like "Entities::BaseEntity#initialize"
  input_args = { id: 123, country: "United States", state: "New Hampshire" }
  it_behaves_like("Entities::HasDbEntity.from_db_entity", input_args) do
    before :each do
      allow(entity).to receive(:country) { "US" }
      allow(Entities::Country).to receive(:from_code).with("US") { "United States" }
      allow(entity).to receive(:state) { "NH" }
      allow(Entities::State).to receive(:from_code).with(code: "NH", country_code: "US") { "New Hampshire" }
    end
  end
  es_args = { country: "Country", state: "State" }
  it_behaves_like("Entities::HasElasticsearch.from_es_response", es_args) do
    before :each do
      allow(Entities::Country).to receive(:from_es_response) { "Country" }
      allow(Entities::State).to receive(:from_es_response) { "State" }
    end
  end

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
        country: "United States",
        state: "California",
        zip_code: "95014-2083"
      }
    end
    let!(:response) { json_fixture("/api_responses/iex/company.json") }
    subject { described_class.from_iex_response(response) }

    it "expect to create an entity with args" do
      expect(Entities::Country).to receive(:from_code).with("US") { "United States" }
      expect(Entities::State).to receive(:from_code).with(code: "CA", country_code: "US") { "California" }
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
