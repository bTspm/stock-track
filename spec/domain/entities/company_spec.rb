require "rails_helper"

describe Entities::Company do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) do
    {
     address: address,
     description: description,
     employees: employees,
     exchange: exchange,
     executives: executives,
     id: id,
     industry: industry,
     issuer_type: issuer_type,
     name: name,
     sector: sector,
     security_name: security_name,
     sic_code: sic_code,
     symbol: symbol,
     website: website,
    }
  end
  let(:address) { double(:address) }
  let(:description) { double(:description) }
  let(:employees) { double(:employees) }
  let(:exchange) { double(:exchange) }
  let(:executives) { double(:executives) }
  let(:id) { double(:id) }
  let(:industry) { double(:industry) }
  let(:issuer_type) { double(:issuer_type) }
  let(:name) { double(:name) }
  let(:phone) { double(:phone) }
  let(:sector) { double(:sector) }
  let(:security_name) { double(:security_name) }
  let(:sic_code) { double(:sic_code) }
  let(:symbol) { double(:symbol) }
  let(:website) { double(:website) }

  subject(:company) { described_class.new(args) }

  describe ".from_db_entity" do
    let(:address_entity) { double(:address_entity) }
    let(:entity) do
      double(
       :entity,
       address: address_entity,
       company_executives: executive_entities,
       exchange: exchange_entity,
       issuer_type: issuer_type_entity
      )
    end
    let(:exchange_entity) { double(:exchange_entity) }
    let(:executive_entity) { double(:executive_entity) }
    let(:executive_entities) { [executive_entity] }
    let(:executive) { double(:executive) }
    let(:issuer_type_entity) { double(:issuer_type_entity) }

    subject { described_class.from_db_entity(entity) }

    context "without entity" do
      let(:entity) { nil }

      it { is_expected.to be_nil }
    end

    context "with entity" do
      let(:args) do
        {
         address: address,
         exchange: exchange,
         executives: [executive],
         issuer_type: issuer_type,
         test: 123
        }
      end
      let(:attributes) { { test: 123 } }

      it "expect to return company with properties" do
        expect(Entities::Address).to receive(:from_db_entity).with(address_entity) { address }
        expect(Entities::CompanyExecutive).to receive(:from_db_entity).with(executive_entity) { executive }
        expect(Entities::Exchange).to receive(:from_db_entity).with(exchange_entity) { exchange }
        expect(Entities::IssuerType).to receive(:from_db_entity).with(issuer_type_entity) { issuer_type }
        expect(entity).to receive(:attributes) { attributes }
        expect(described_class).to receive(:new).with(args)

        subject
      end
    end
  end

  describe ".from_iex_response" do
    let(:args) do
      {
       address: address,
       description: "Test Description",
       employees: 137000,
       exchange: exchange,
       industry: "Telecommunications Equipment",
       issuer_type: issuer_type,
       name: "Apple, Inc.",
       phone: "1.408.996.1010",
       sector: "Electronic Technology",
       security_name: "Apple Inc.",
       sic_code: 3663,
       symbol: "AAPL",
       website: "http://www.apple.com"
      }
    end
    let!(:response) { json_fixture("/api_responses/iex/company.json") }

    subject(:company) { described_class.from_iex_response(response) }

    it "expect to create an entity with args" do
      expect(Entities::Address).to receive(:from_iex_response).with(response) { address }
      expect(Entities::Exchange).to receive(:from_iex_company_response).with(response) { exchange }
      expect(Entities::IssuerType).to receive(:from_iex_company_response).with(response) { issuer_type }
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end

  describe "#etf?" do
    subject { company.etf? }

    context "without issuer_type" do
      let(:issuer_type) { nil }

      it { is_expected.to be_nil }
    end

    context "with issuer_type" do
      it "delegates to issuer_type's etf" do
        expect(issuer_type).to receive(:etf?) { "Result" }

        subject
      end
    end
  end
end
