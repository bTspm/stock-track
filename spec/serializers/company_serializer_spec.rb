require "rails_helper"

describe CompanySerializer do
  let(:args) do
    {
      address_city: "address_city",
      address_country_alpha2: "address_country_alpha2",
      address_country_code: "address_country_code",
      address_country_name: "address_country_name",
      address_line1: "address_line1",
      address_line2: "address_line2",
      address_state_code: "address_state_code",
      address_state_name: "address_state_name",
      description: "description",
      exchange_code: "exchange_code",
      exchange_country_alpha2: "exchange_country_alpha2",
      exchange_country_code: "exchange_country_code",
      exchange_country_name: "exchange_country_name",
      exchange_name: "exchange_name",
      id: "id",
      industry: "industry",
      issuer_type_code: "issuer_type_code",
      issuer_type_name: "issuer_type_name",
      name: "name",
      sector: "sector",
      security_name: "security_name",
      sic_code: "sic_code",
      symbol: "symbol",
    }
  end
  subject(:serializer) { described_class.new(args) }

  describe '#initialize' do
    it { is_expected.to be_kind_of described_class }

    context "properties" do
      it { expect(serializer.address_city).to eq "address_city" }
      it { expect(serializer.address_country_alpha2).to eq "address_country_alpha2" }
      it { expect(serializer.address_country_code).to eq "address_country_code" }
      it { expect(serializer.address_country_name).to eq "address_country_name" }
      it { expect(serializer.address_line1).to eq "address_line1" }
      it { expect(serializer.address_line2).to eq "address_line2" }
      it { expect(serializer.address_state_code).to eq "address_state_code" }
      it { expect(serializer.address_state_name).to eq "address_state_name" }
      it { expect(serializer.description).to eq "description" }
      it { expect(serializer.exchange_code).to eq "exchange_code" }
      it { expect(serializer.exchange_country_alpha2).to eq "exchange_country_alpha2" }
      it { expect(serializer.exchange_country_code).to eq "exchange_country_code" }
      it { expect(serializer.exchange_country_name).to eq "exchange_country_name" }
      it { expect(serializer.exchange_name).to eq "exchange_name" }
      it { expect(serializer.id).to eq "id" }
      it { expect(serializer.industry).to eq "industry" }
      it { expect(serializer.issuer_type_code).to eq "issuer_type_code" }
      it { expect(serializer.issuer_type_name).to eq "issuer_type_name" }
      it { expect(serializer.name).to eq "name" }
      it { expect(serializer.sector).to eq "sector" }
      it { expect(serializer.security_name).to eq "security_name" }
      it { expect(serializer.sic_code).to eq "sic_code" }
      it { expect(serializer.symbol).to eq "symbol" }
    end
  end

  describe ".from_domain_entity" do
    subject { described_class.from_domain_entity(company).as_json }

    context "with address" do
      let(:company) { build :entity_company }
      it "expect to return a serializer object" do
        result_hash = {
          address_city: "Test City",
          address_country_alpha2: "US",
          address_country_code: "USA",
          address_country_name: "United States of America",
          address_line1: "231 Abc Avenue",
          address_line2: "Suite 200",
          address_state_code: "NH",
          address_state_name: "New Hampshire",
          description: "Test",
          exchange_code: "NYSE",
          exchange_country_alpha2: "US",
          exchange_country_code: "USA",
          exchange_country_name: "United States of America",
          exchange_name: "New York Stock Exchange",
          id: 200,
          industry: "Telecommunications Equipment",
          issuer_type_code: "CS",
          issuer_type_name: "Common Stock",
          name: "Apple Inc.",
          sector: "Electronic Technology",
          security_name: "Apple Inc.",
          sic_code: 3663,
          symbol: "AAPL"
        }.with_indifferent_access

        expect(subject).to eq result_hash
      end
    end

    context "without address" do
      let(:company) { build :entity_company, :company_without_address }
      it "expect to return a serializer object" do
        result_hash = {
          address_city: nil,
          address_country_alpha2: nil,
          address_country_code: nil,
          address_country_name: nil,
          address_line1: nil,
          address_line2: nil,
          address_state_code: nil,
          address_state_name: nil,
          description: "Test",
          exchange_code: "NYSE",
          exchange_country_alpha2: "US",
          exchange_country_code: "USA",
          exchange_country_name: "United States of America",
          exchange_name: "New York Stock Exchange",
          id: 200,
          industry: "Telecommunications Equipment",
          issuer_type_code: "CS",
          issuer_type_name: "Common Stock",
          name: "Apple Inc.",
          sector: "Electronic Technology",
          security_name: "Apple Inc.",
          sic_code: 3663,
          symbol: "AAPL"
        }.with_indifferent_access

        expect(subject).to eq result_hash
      end
    end
  end
end
