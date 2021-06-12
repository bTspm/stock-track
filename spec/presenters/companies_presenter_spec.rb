require "rails_helper"

describe CompaniesPresenter do
  describe ".scalar" do
    let(:company) { build :entity_company }
    subject(:presenter) { described_class::Scalar.new(company, view_context) }

    context "delegate" do
      context "address" do
        it { should delegate_method(:formatted).to(:address).with_prefix(true) }
      end

      context "issuer_type" do
        it { should delegate_method(:name_with_code).to(:issuer_type).with_prefix(true) }
      end
    end

    describe "#address" do
      subject { presenter.address }

      it "expect to return address presenter" do
        expect(AddressesPresenter).to receive(:present).with(company.address, view_context) { "Address" }

        expect(subject).to eq "Address"
      end
    end

    describe "#autocomplete_response" do
      subject { presenter.autocomplete_response }

      it "expect to return a hash with search response" do
        expect(subject).to eq(
                             exchange_name: "New York Stock Exchange",
                             id: "AAPL",
                             logo_url: "https://storage.googleapis.com/iexcloud-hl37opg/api/logos/AAPL.png",
                             security_name_with_symbol: "Apple Inc. - AAPL",
                             value: "Test Apple Inc. Apple Inc. AAPL"
                           )
      end
    end

    describe "#employees" do
      subject { presenter.employees }

      context "without employees" do
        let(:company) { build :entity_company, employees: nil }

        it { is_expected.to eq "N/A" }
      end

      context "with employees" do
        it "expect to return formatted employees" do
          expect(view_context).to receive(:st_number_with_delimiter).with(137_000) { "Delim Number" }

          expect(subject).to eq "~Delim Number"
        end
      end
    end

    describe "#external_analysis" do
      subject { presenter.external_analysis }

      it "expect to return external_analysis presenter" do
        expect(
          ExternalAnalysisPresenter
        ).to receive(:present).with(company.external_analysis, view_context) { "External Analysis" }

        expect(subject).to eq "External Analysis"
      end
    end

    describe "#company_executives" do
      subject { presenter.company_executives }

      context "without company_executives" do
        let(:company_executives) { nil }
        it { is_expected.to match_array [] }
      end

      context "with company_executives" do
        let(:company) { build :entity_company, company_executives: "executives" }

        it "expect to return exchange presenter" do
          expect(
            CompanyExecutivesPresenter
          ).to receive(:present).with(company.company_executives, view_context) { "Executives" }

          expect(subject).to eq "Executives"
        end
      end
    end

    describe "#issuer_type" do
      subject { presenter.issuer_type }

      it "expect to return issuer_type presenter" do
        expect(IssuerTypesPresenter).to receive(:present).with(company.issuer_type, view_context) { "Issuer Type" }

        expect(subject).to eq "Issuer Type"
      end
    end

    describe "#logo_url" do
      subject { presenter.logo_url }

      it "expect to include symbol" do
        expect(subject).to eq "https://storage.googleapis.com/iexcloud-hl37opg/api/logos/AAPL.png"
      end
    end

    describe "#select_picker_response" do
      subject { presenter.select_picker_response }

      it "expect to return has with id and text" do
        expect(subject).to eq(id: "AAPL", text: "Apple Inc.")
      end
    end

    describe "#stock_info_link_with_name" do
      subject { presenter.stock_info_link_with_name }

      it "expect to call view context and generate link" do
        expect(view_context).to receive(:stock_information_link_with_company_name).with(presenter) { "Company Link" }

        expect(subject).to eq "Company Link"
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
