require "rails_helper"

describe Entities::IssuerType do
  it_behaves_like 'Entities::BaseEntity#initialize'
  it_behaves_like 'Entities::DbEntity.from_db_entity'

  let(:args) { { code: code, id: id, name: name } }
  let(:code) { double(:code) }
  let(:id) { double(:id) }
  let(:name) { double(:name) }

  subject(:issuer_type) { described_class.new(args) }

  describe ".from_iex_company_response" do
    let(:response) { { issueType: code } }

    subject { described_class.from_iex_company_response(response) }

    it "expect to return issuer_type with properties" do
      expect(subject.code).to eq code
    end
  end

  describe "#etf?" do
    subject { issuer_type.etf? }

    context "not an etf" do
      context "without code" do
        let(:code) { nil }

        it { is_expected.to be_falsey }
      end

      context "with code" do
        let(:code) { "NOT ETF" }

        it { is_expected.to be_falsey }
      end
    end

    context "is etf" do
      let(:code) { described_class::ETF_CODE }

      it { is_expected.to be_truthy }
    end
  end
end
