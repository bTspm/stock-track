require "rails_helper"

describe Entities::Exchange do
  it_behaves_like "Entities::BaseEntity#initialize"
  input_args = { id: 123, country: "United States" }
  it_behaves_like("Entities::HasDbEntity.from_db_entity", input_args) do
    before :each do
      allow(entity).to receive(:country) { "US" }
      allow(Entities::Country).to receive(:from_code).with("US") { "United States" }
    end
  end
  it_behaves_like("Entities::HasElasticsearch.from_es_response", { country: "Country" }) do
    before :each do
      allow(Entities::Country).to receive(:from_es_response) { "Country" }
    end
  end

  let(:args) do
    {
      code: code,
      country: country,
      id: id,
      name: name
    }
  end
  let(:code) { double(:code) }
  let(:country) { double(:country) }
  let(:id) { double(:id) }
  let(:name) { double(:name) }

  describe ".from_iex_company_response" do
    let(:response) { { exchange: name } }

    subject { described_class.from_iex_company_response(response) }

    it "expect to return exchange with properties" do
      expect(subject.name).to eq name
    end
  end

  describe ".from_iex_response" do
    let(:args) { { code: "NYS", country: "United States", name: "New York Stock Exchange" } }
    let!(:response) { json_fixture("/api_responses/iex/exchanges.json").last }

    subject { described_class.from_iex_response(response) }

    it "expect to create an entity with args" do
      allow(Entities::Country).to receive(:from_code).with("US") { "United States" }
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
