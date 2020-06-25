require "rails_helper"

describe CompanyService do
  it_behaves_like "Services#stock_service"

  let(:company) { double(:company) }
  let(:service) { described_class.new }
  let(:symbol) { double(:symbol) }

  describe "#company_by_symbol" do
    subject { service.company_by_symbol(symbol) }

    before { expect(service).to receive_message_chain(:company_storage, :by_symbol).with(symbol) { company } }

    context "with company" do
      it { is_expected.to eq company }
    end

    context "without company" do
      let(:company) { nil }

      it "expect to call and create company" do
        expect(service).to receive(:create_or_update_company_by_symbol).with(symbol) { "Company Created" }

        expect(subject).to eq "Company Created"
      end
    end
  end

  describe "#create_or_update_company_by_symbol" do
    let(:company) { OpenStruct.new(executives: nil) }
    let(:company_store) { double(:company_store) }

    subject { service.create_or_update_company_by_symbol(symbol) }

    it "expect to get company from iex and finn hub and save company" do
      expect(service).to receive(:company_storage).ordered { company_store }
      expect(company_store).to receive(:by_symbol_from_iex).with(symbol) { company }
      expect(
        service
      ).to receive_message_chain(:company_executive_storage, :by_symbol_from_finn_hub).with(symbol) { "Executives" }
      expect(service).to receive(:company_storage).ordered { company_store }
      expect(company_store).to receive(:save_company).with(company) { "Saved" }

      expect(subject).to eq "Saved"
    end
  end
end
