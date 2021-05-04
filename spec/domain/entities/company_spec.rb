require "rails_helper"

describe Entities::Company do
  it_behaves_like "Entities::BaseEntity#initialize"
  input_args = {
    address: "Address",
    company_executives: ["Company Executive"],
    exchange: "Exchange",
    external_analysis: "External Analysis",
    id: 123,
    issuer_type: "Issuer Type"
  }
  it_behaves_like("Entities::HasDbEntity.from_db_entity", input_args) do
    before :each do
      allow(entity).to receive(:address) { "address" }
      allow(Entities::Address).to receive(:from_db_entity).with("address") { "Address" }
      allow(entity).to receive(:company_executives) { ["company_executive"] }
      allow(Entities::CompanyExecutive).to receive(:from_db_entity).with("company_executive") { "Company Executive" }
      allow(entity).to receive(:exchange) { "exchange" }
      allow(Entities::Exchange).to receive(:from_db_entity).with("exchange") { "Exchange" }
      allow(entity).to receive(:issuer_type) { "issuer_type" }
      allow(Entities::IssuerType).to receive(:from_db_entity).with("issuer_type") { "Issuer Type" }
      allow(entity).to receive(:external_analysis) { "external_analysis" }
      allow(Entities::ExternalAnalysis).to receive(:from_json).with("external_analysis") { "External Analysis" }
    end
  end
  es_args = { address: "Address", exchange: "Exchange", issuer_type: "Issuer Type" }
  it_behaves_like("Entities::HasElasticsearch.from_es_response", es_args) do
    before :each do
      allow(Entities::Address).to receive(:from_es_response) { "Address" }
      allow(Entities::Exchange).to receive(:from_es_response) { "Exchange" }
      allow(Entities::IssuerType).to receive(:from_es_response) { "Issuer Type" }
    end
  end

  let(:args) do
    {
      address: address,
      company_executives: company_executives,
      description: description,
      employees: employees,
      exchange: exchange,
      external_analysis: external_analysis,
      id: id,
      industry: industry,
      issuer_type: issuer_type,
      name: name,
      phone: phone,
      sector: sector,
      security_name: security_name,
      sic_code: sic_code,
      symbol: symbol,
      website: website
    }
  end
  let(:address) { double(:address) }
  let(:company_executives) { double(:company_executives) }
  let(:description) { double(:description) }
  let(:employees) { double(:employees) }
  let(:exchange) { double(:exchange) }
  let(:external_analysis) { double(:external_analysis) }
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

  describe ".from_iex_response" do
    let(:args) do
      {
        address: address,
        description: "Test Description",
        employees: 137_000,
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
