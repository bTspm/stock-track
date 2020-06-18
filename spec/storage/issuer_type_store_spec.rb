require "rails_helper"

describe IssuerTypeStore do
  let(:cache_key) { "key" }
  let(:domain_class) { Entities::IssuerType }
  subject(:store) { described_class.new }

  before do
    Rails.cache.clear
    allow_any_instance_of(described_class).to receive(:fetch_cached).with(key: cache_key).and_call_original
  end

  describe "#by_code" do
    let(:cache_key) { "IssuerTypeStore/by_code/New York Stock IssuerType" }
    let(:issuer_types) { [issuer_type] }
    let(:issuer_type) { double(:issuer_type) }
    let(:code) { "New York Stock IssuerType" }

    subject { store.by_code(code) }

    it "expect to retrieve from db and build domain" do
      expect(IssuerType).to receive(:where).with(code: code) { issuer_types }
      expect(domain_class).to receive(:from_db_entity).with(issuer_type) { "IssuerType Domain" }

      expect(subject).to eq "IssuerType Domain"
    end
  end

  describe "#by_id" do
    let(:cache_key) { "IssuerTypeStore/by_id/1" }
    let(:issuer_type) { double(:issuer_type) }
    let(:id) { 1 }

    subject { store.by_id(id) }

    it "expect to retrieve from db and build domain" do
      expect(IssuerType).to receive(:find).with(id) { issuer_type }
      expect(domain_class).to receive(:from_db_entity).with(issuer_type) { "IssuerType Domain" }

      expect(subject).to eq "IssuerType Domain"
    end
  end
end
