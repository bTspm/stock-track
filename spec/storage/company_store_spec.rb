require "rails_helper"

describe CompanyStore do
  let(:cache_key) { "cache" }
  let(:domain_class) { Entities::Company }
  subject(:store) { CompanyStore.new }

  before do
    Rails.cache.clear
    allow_any_instance_of(described_class).to receive(:fetch_cached).with(key: cache_key).and_call_original
  end

  describe "#by_symbol" do
    let(:cache_key) { "CompanyStore/by_symbol/ABC" }
    let(:companies) { [company] }
    let(:company) { double(:company) }
    let(:symbol) { "ABC" }

    subject { store.by_symbol(symbol) }

    it "expect to get response from db and build domain entity" do
      expect(Company).to receive_message_chain(:includes, :references, :where).with(symbol: symbol) { companies }
      expect(domain_class).to receive(:from_db_entity).with(company) { "company_object" }

      expect(subject).to eq "company_object"
    end
  end

  describe "#by_symbol_from_iex" do
    let(:cache_key) { "CompanyStore/by_symbol_from_iex/ABC" }
    let(:companies) { [company] }
    let(:company) { double(:company) }
    let(:symbol) { "ABC" }

    subject { store.by_symbol_from_iex(symbol) }

    it "expect to call by_symbols_from_iex" do
      expect(store).to receive(:by_symbols_from_iex).with(symbol) { companies }

      expect(subject).to eq company
    end
  end

  describe "#by_symbols_from_iex" do
    let(:company) do
      OpenStruct.new(
        {
          exchange: nil,
          exchange_name: "exchange_name",
          issuer_type: nil,
          issuer_type_code: "issuer_type_code"
        }
      )
    end
    let(:company_response) { double(:company_response) }
    let(:response) { double(:response, body: { ABC: { company: company_response } }) }
    let(:symbol) { "ABC" }

    subject { store.by_symbols_from_iex(symbol) }

    it "expect to get response from iex and build domain entity" do
      expect(store).to receive_message_chain(:iex_client, :information_by_symbols).with(
        symbols: %w[ABC], options: { types: "company" }
      ) { response }
      expect(domain_class).to receive(:from_iex_response).with(company_response) { company }
      expect(ExchangeStore).to receive_message_chain(:new, :by_name).with("exchange_name") { "Exchange" }
      expect(IssuerTypeStore).to receive_message_chain(:new, :by_code).with("issuer_type_code") { "Issuer Type" }

      expect(subject).to eq [company]
    end
  end

  describe "#save_company" do
    let(:builder) { double(:builder) }
    let(:companies) { [company] }
    let(:company_entity) { double(:company_entity, symbol: symbol) }
    let(:company) { build(:company) }
    let(:symbol) { "AAPL" }

    subject { store.save_company(company_entity) }

    before do
      expect(Company).to receive_message_chain(:includes, :references, :where).with(symbol: symbol) { companies }
      expect(CompanyBuilder).to receive(:new).with(company) { builder }
      expect(builder).to receive(:build_full_company_from_domain).with(company_entity) { company }
      expect(domain_class).to receive(:from_db_entity).with(company) { "Company" }
    end

    context "save successful" do
      it "expect to save company and return domain entity" do
        expect(company).to receive(:save!) { "Saved" }
        expect(Rails).to receive_message_chain(:logger, :info).with("Company saved: AAPL") { "Logged" }

        subject
      end
    end

    context "save unsuccessful" do
      it "expect to log and raise an error" do
        expect(company).to receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(company))
        expect(Rails).to receive_message_chain(:logger, :error).with(
          "Company save failed: AAPL with errors: Validation failed: "
        ) { "Error Logged" }

        expect { subject }.to raise_error AppExceptions::RecordInvalid
      end
    end
  end

  describe "#snp500_company_symbols_from_github" do
    let(:response) { double(:response, body: "ABC\nDEF") }
    subject { store.snp500_company_symbols_from_github }

    it "expect to call information_by_symbols and build growth" do
      expect(Scraper::GithubClient).to receive_message_chain(:new, :snp500_symbols) { response }

      expect(subject).to eq %w[ABC DEF]
    end
  end
end
