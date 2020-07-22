require "rails_helper"

describe CompanyService do
  it_behaves_like "Services#stock_service"

  let(:company) { double(:company) }
  let(:service) { described_class.new }
  let(:symbol) { double(:symbol) }

  describe "#basic_search" do
    let(:search_text) { double(:search_text) }
    subject { service.basic_search(search_text) }

    it "expect to call store and retrieve companies" do
      expect(
        service
      ).to receive_message_chain(:company_storage, :basic_search_from_es).with(search_text) { "Companies" }

      expect(subject).to eq "Companies"
    end
  end

  describe "#company_by_symbol" do
    subject { service.company_by_symbol(symbol) }

    before { expect(service).to receive_message_chain(:company_storage, :by_symbol).with(symbol) { company } }

    context "with company" do
      it { is_expected.to eq company }
    end

    context "without company" do
      let(:company) { nil }

      it "expect to call and create company" do
        expect(service).to receive(:save_company_by_symbol).with(symbol) { "Company Created" }

        expect(subject).to eq "Company Created"
      end
    end
  end

  describe "#index_companies" do
    let(:offset) { double(:offset) }
    let(:limit) { double(:limit) }
    subject { service.index_companies(offset: offset, limit: limit) }

    it "expect to call store and retrieve companies" do
      expect(service).to receive_message_chain(
                           :company_storage,
                           :index_companies_by_offset_limit
                         ).with(offset: offset, limit: limit) { "Companies" }

      expect(subject).to eq "Companies"
    end
  end

  describe "#save_company_by_symbol" do
    let(:company) { OpenStruct.new(executives: nil) }
    let(:company_store) { double(:company_store) }

    subject { service.save_company_by_symbol(symbol) }

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

  describe "#snp500_company_symbols" do
    subject { service.snp500_company_symbols }

    it "expect to call exchange_store and get snp500 company symbols" do
      expect(service).to receive_message_chain(:company_storage, :snp500_company_symbols_from_github) { "SNP500" }

      expect(subject).to eq "SNP500"
    end
  end
end
