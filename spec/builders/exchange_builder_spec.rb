require "rails_helper"

describe ExchangeBuilder do
  it_behaves_like "BaseBuilder#initialize"
  it_behaves_like "BaseBuilder#build"
  it_behaves_like "BaseBuilder#build_base_entity_from_domain"

  let(:builder) { double(:builder) }
  let(:db_entity) { OpenStruct.new({ country: nil }) }
  subject(:exchange_builder) { described_class.new(db_entity) }

  describe "#build_full_company_from_domain" do
    let(:country_alpha2) { double(:country_alpha2) }
    let(:domain_entity) { double(:domain_entity, country_alpha2: country_alpha2) }
    subject { exchange_builder.build_full_exchange_from_domain(domain_entity) }

    it "expect to build full exchange" do
      expect(exchange_builder).to receive(:build).and_yield(builder)
      expect(builder).to receive(:build_base_entity_from_domain).with(domain_entity) { "Built with basic attributes" }
      expect(builder).to receive(:set_country).with(country_alpha2) { "Built country" }

      subject
    end
  end

  describe "#set_country" do
    subject { exchange_builder.set_country("ABC") }

    it "expect to assign country" do
      subject
      expect(db_entity.country).to eq "ABC"
    end
  end
end
