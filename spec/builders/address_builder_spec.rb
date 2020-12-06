require "rails_helper"

describe AddressBuilder do
  it_behaves_like "BaseBuilder#initialize"
  it_behaves_like "BaseBuilder#build"
  it_behaves_like "BaseBuilder#build_base_entity_from_domain"
  it_behaves_like "BaseBuilder#build_base_entity_from_params"

  let(:builder) { double(:builder) }
  let(:db_entity) { OpenStruct.new({ country: nil, state: nil }) }
  subject(:address_builder) { described_class.new(db_entity) }

  describe "#build_full_company_from_domain" do
    let(:country_alpha2) { double(:country_alpha2) }
    let(:domain_entity) { double(:domain_entity, country_alpha2: country_alpha2, state_code: state_code) }
    let(:state_code) { double(:state_code) }
    subject { address_builder.build_full_address_from_domain(domain_entity) }

    it "expect to build full address" do
      expect(address_builder).to receive(:build).and_yield(builder)
      expect(builder).to receive(:build_base_entity_from_domain).with(domain_entity) { "Built with basic attributes" }
      expect(builder).to receive(:set_country).with(country_alpha2) { "Built country" }
      expect(builder).to receive(:set_state).with(state_code) { "Built state" }

      subject
    end
  end

  describe "#set_country" do
    subject { address_builder.set_country("ABC") }

    it "expect to assign country" do
      subject
      expect(db_entity.country).to eq "ABC"
    end
  end

  describe "#set_state" do
    subject { address_builder.set_state("ABC") }

    it "expect to assign stats" do
      subject
      expect(db_entity.state).to eq "ABC"
    end
  end
end
