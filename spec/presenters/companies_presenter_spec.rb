require "rails_helper"

describe CompaniesPresenter do
  describe ".scalar" do
    let(:address) { double(:address) }
    let(:address_presenter) { double(:address_presenter) }
    let(:company_executives) { double(:company_executives) }
    let(:description) { "Description" }
    let(:employees) { 2_000 }
    let(:exchange) { double(:exchange) }
    let(:exchange_presenter) { double(:exchange_presenter) }
    let(:issuer_type) { double(:issuer_type) }
    let(:issuer_type_presenter) { double(:issuer_type_presenter) }
    let(:name) { "Name" }
    let(:object) do
      double(
        :object,
        address: address,
        company_executives: company_executives,
        description: description,
        employees: employees,
        exchange: exchange,
        issuer_type: issuer_type,
        name: name,
        security_name: security_name,
        symbol: symbol
      )
    end
    let(:security_name) { "Security Name" }
    let(:symbol) { "Symbol" }
    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    context "delegate" do
      context "address" do
        it { should delegate_method(:formatted).to(:address).with_prefix(true) }
      end

      context "exchange" do
        it { should delegate_method(:country_alpha2).to(:exchange).with_prefix(true) }
        it { should delegate_method(:name_with_country_code).to(:exchange).with_prefix(true) }
      end

      context "issuer_type" do
        it { should delegate_method(:name_with_code).to(:issuer_type).with_prefix(true) }
      end
    end

    describe "#address" do
      subject { presenter.address }

      it "expect to return address presenter" do
        expect(AddressesPresenter).to receive(:present).with(address, view_context) { "Address" }

        expect(subject).to eq "Address"
      end
    end

    describe "#autocomplete_response" do
      subject { presenter.autocomplete_response }

      it "expect to return a hash with search response" do
        expect(ExchangesPresenter).to receive(:present).with(exchange, view_context) { exchange_presenter }
        expect(exchange_presenter).to receive(:name_with_country_code) { "NYSE (USA)" }

        expect(subject).to eq(
                             exchange_name_with_country_code: "NYSE (USA)",
                             id: "Symbol",
                             logo_url: "https://storage.googleapis.com/iexcloud-hl37opg/api/logos/Symbol.png",
                             security_name_with_symbol: "Security Name - SYMBOL",
                             value: "Description Name Security Name Symbol"
                           )
      end
    end

    describe "#employees" do
      subject { presenter.employees }

      context "without employees" do
        let(:employees) { nil }
        it { is_expected.to eq "N/A" }
      end

      context "with employees" do
        it "expect to return formatted employees" do
          expect(subject).to eq "~2,000"
        end
      end
    end

    describe "#exchange" do
      subject { presenter.exchange }

      it "expect to return exchange presenter" do
        expect(ExchangesPresenter).to receive(:present).with(exchange, view_context) { "Exchange" }

        expect(subject).to eq "Exchange"
      end
    end

    describe "#company_executives" do
      subject { presenter.company_executives }

      context "without company_executives" do
        let(:company_executives) { nil }
        it { is_expected.to match_array [] }
      end

      context "with company_executives" do
        it "expect to return exchange presenter" do
          expect(
            CompanyExecutivesPresenter
          ).to receive(:present).with(company_executives, view_context) { "Executives" }

          expect(subject).to eq "Executives"
        end
      end
    end

    describe "#issuer_type" do
      subject { presenter.issuer_type }

      it "expect to return issuer_type presenter" do
        expect(IssuerTypesPresenter).to receive(:present).with(issuer_type, view_context) { "Issuer Type" }

        expect(subject).to eq "Issuer Type"
      end
    end

    describe "#logo_url" do
      subject { presenter.logo_url }

      it "expect to include symbol" do
        expect(subject).to include "Symbol"
      end
    end

    describe "#name_with_symbol" do
      subject { presenter.name_with_symbol }

      it "expect to to return name with symbol" do
        expect(subject).to eq "Name - (SYMBOL)"
      end
    end

    describe "#select_picker_response" do
      subject { presenter.select_picker_response }

      it "expect to return has with id and text" do
        expect(subject).to eq(id: "Symbol", text: "Security Name")
      end
    end
  end

  describe ".enum" do
    let(:object) { double(:object) }
    let(:objects) { [object] }
    subject(:presenter) { described_class::Enum.new(objects, view_context) }

    describe "#autocomplete_response" do
      subject { presenter.autocomplete_response }

      context "with companies" do
        it "expect to return autocomplete response" do
          expect_any_instance_of(described_class::Scalar).to receive(:autocomplete_response) { "Search Response" }

          expect(subject).to match_array ["Search Response"]
        end
      end

      context "without companies" do
        let(:objects) { nil }

        it { is_expected.to eq [] }
      end
    end

    describe "#select_picker_response" do
      subject { presenter.select_picker_response }

      context "with companies" do
        it "expect to return select picker response" do
          expect_any_instance_of(described_class::Scalar).to receive(:select_picker_response) { "Picker Response" }

          expect(subject).to match_array ["Picker Response"]
        end
      end

      context "without companies" do
        let(:objects) { nil }

        it { is_expected.to eq [] }
      end
    end
  end
end
