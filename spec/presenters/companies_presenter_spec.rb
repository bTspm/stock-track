require "rails_helper"

describe CompaniesPresenter do
  describe ".scalar" do
    let(:address) { double(:address) }
    let(:address_presenter) { double(:address_presenter) }
    let(:employees) { 2_000 }
    let(:exchange) { double(:exchange) }
    let(:exchange_presenter) { double(:exchange_presenter) }
    let(:executives) { double(:executives) }
    let(:issuer_type) { double(:issuer_type) }
    let(:issuer_type_presenter) { double(:issuer_type_presenter) }
    let(:name) { "Name" }
    let(:symbol) { "Symbol" }
    let(:object) do
      double(
        :object,
        address: address,
        employees: employees,
        exchange: exchange,
        executives: executives,
        issuer_type: issuer_type,
        name: name,
        symbol: symbol
      )
    end

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#address" do
      subject { presenter.address }

      it "expect to return address presenter" do
        expect(AddressesPresenter).to receive(:present).with(address, view_context) { "Address" }

        expect(subject).to eq "Address"
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

    describe "#executives" do
      subject { presenter.executives }

      context "without executives" do
        let(:executives) { nil }
        it { is_expected.to match_array [] }
      end

      context "with executives" do
        it "expect to return exchange presenter" do
          expect(CompanyExecutivesPresenter).to receive(:present).with(executives, view_context) { "Executives" }

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

    describe "#formatted" do
      subject { presenter.address_formatted }

      it "delegates to address's formatted" do
        expect(AddressesPresenter).to receive(:present).with(address, view_context) { address_presenter }
        expect(address_presenter).to receive(:formatted) { "Formatted Address" }

        expect(subject).to eq "Formatted Address"
      end
    end

    describe "#country" do
      subject { presenter.exchange_country }

      it "delegates to exchange's country" do
        expect(ExchangesPresenter).to receive(:present).with(exchange, view_context) { exchange_presenter }
        expect(exchange_presenter).to receive(:country) { "Exchange Country" }

        expect(subject).to eq "Exchange Country"
      end
    end

    describe "#name_with_country" do
      subject { presenter.exchange_name_with_country }

      it "delegates to exchange's name_with_country" do
        expect(ExchangesPresenter).to receive(:present).with(exchange, view_context) { exchange_presenter }
        expect(exchange_presenter).to receive(:name_with_country) { "Exchange name_with_country" }

        expect(subject).to eq "Exchange name_with_country"
      end
    end

    describe "#name_with_code" do
      subject { presenter.issuer_type_name_with_code }

      it "delegates to issuer_type_name's name_with_code" do
        expect(IssuerTypesPresenter).to receive(:present).with(issuer_type, view_context) { issuer_type_presenter }
        expect(issuer_type_presenter).to receive(:name_with_code) { "Issuer Type name_with_code" }

        expect(subject).to eq "Issuer Type name_with_code"
      end
    end
  end
end
