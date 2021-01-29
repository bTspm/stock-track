require "rails_helper"

describe ExchangeStore do
  let(:cache_key) { "key" }
  let(:domain_class) { Entities::Exchange }
  subject(:store) { described_class.new }

  before do
    Rails.cache.clear
    allow_any_instance_of(described_class).to receive(:fetch_cached).with(key: cache_key).and_call_original
  end

  describe "#by_code" do
    let(:cache_key) { "ExchangeStore/by_code/NYS" }
    let(:exchange) { double(:exchange) }
    let(:code) { "NYS" }

    subject { store.by_code(code) }

    it "expect to retrieve from db and build domain" do
      expect(Exchange).to receive(:find_by).with(code: code) { exchange }
      expect(domain_class).to receive(:from_db_entity).with(exchange) { "Exchange Domain" }

      expect(subject).to eq "Exchange Domain"
    end
  end

  describe "#by_id" do
    let(:cache_key) { "ExchangeStore/by_id/1" }
    let(:exchange) { double(:exchange) }
    let(:id) { 1 }

    subject { store.by_id(id) }

    it "expect to retrieve from db and build domain" do
      expect(Exchange).to receive(:find).with(id) { exchange }
      expect(domain_class).to receive(:from_db_entity).with(exchange) { "Exchange Domain" }

      expect(subject).to eq "Exchange Domain"
    end
  end

  describe "#by_name" do
    let(:cache_key) { "ExchangeStore/by_name/New York Stock Exchange" }
    let(:exchange) { double(:exchange) }
    let(:name) { "New York Stock Exchange" }

    subject { store.by_name(name) }

    it "expect to retrieve from db and build domain" do
      expect(Exchange).to receive(:find_by).with(name: name) { exchange }
      expect(domain_class).to receive(:from_db_entity).with(exchange) { "Exchange Domain" }

      expect(subject).to eq "Exchange Domain"
    end
  end

  describe "#save_exchanges" do
    let(:builder) { double(:builder) }
    let(:exchange_response) { double(:exchange_response) }
    let(:exchange_entity) { build(:entity_exchange) }
    let(:exchange) { build(:exchange) }
    let(:response) { double(:response, body: [exchange_response]) }

    subject { store.save_exchanges }

    before do
      expect(Allocator).to receive_message_chain(:iex_client, :exchanges) { response }
      expect(domain_class).to receive(:from_iex_response).with(exchange_response) { exchange_entity }
    end

    context "exchange usa based" do
      before do
        expect(Exchange).to receive(:find_by).with(code: exchange_entity.code) { exchange }
        expect(ExchangeBuilder).to receive(:new).with(exchange) { builder }
        expect(builder).to receive(:build_full_exchange_from_domain).with(exchange_entity) { exchange }
        expect(domain_class).to receive(:from_db_entity).with(exchange) { "Exchange" }
      end

      context "save successful" do
        it "expect to save exchange and return domain entity" do
          expect(exchange).to receive(:save!) { "Saved" }
          expect(Rails).to receive_message_chain(:logger, :info).with("Exchange saved: NYSE") { "Logged" }

          subject
        end
      end

      context "save unsuccessful" do
        it "expect to log and raise an error" do
          expect(exchange).to receive(:save!).and_raise(ActiveRecord::RecordInvalid.new(exchange))
          expect(Rails).to receive_message_chain(:logger, :error).with(
            "Exchange save failed: New York Stock Exchange with errors: Validation failed: "
          ) { "Error Logged" }

          expect { subject }.to raise_error AppExceptions::RecordInvalid
        end
      end
    end

    context "exchange not based in usa" do
      let(:exchange_entity) { build(:entity_exchange, :non_usa) }

      it "expect not to save" do
        expect(store).not_to receive(:_save_exchange)

        subject
      end
    end
  end
end
