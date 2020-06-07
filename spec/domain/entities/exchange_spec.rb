require "rails_helper"

describe Entities::Exchange do
  it_behaves_like "Entities::BaseEntity#initialize"
  it_behaves_like "Entities::DbEntity.from_db_entity"

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
    let(:args) { { code: "NYS", country: "US", name: "New York Stock Exchange" } }
    let!(:response) { json_fixture("/api_responses/iex/exchanges.json").last }

    subject { described_class.from_iex_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
