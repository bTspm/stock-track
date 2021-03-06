require "rails_helper"

describe CompanyBuilder do
  it_behaves_like "BaseBuilder#initialize"
  it_behaves_like "BaseBuilder#build"
  it_behaves_like "BaseBuilder#build_base_entity_from_domain"

  let(:builder) { double(:builder) }
  let(:db_address) { double(:db_address) }
  let(:db_entity) do
    OpenStruct.new(
      {
        association: builder,
        address: db_address,
        company_executives: db_executives,
        exchange_id: nil,
        external_analysis: nil,
        issuer_type_id: nil
      }
    )
  end
  let(:db_executives) { [db_executive] }
  let(:db_executive) { double(:db_executive, name: db_executive_name) }
  let(:db_executive_name) { double(:db_executive_name) }
  subject(:company_builder) { described_class.new(db_entity) }

  describe "#build_full_company_from_domain" do
    let(:address) { double(:address) }
    let(:exchange_id) { double(:exchange_id) }
    let(:external_analysis) { double(:external_analysis) }
    let(:company_executives) { double(:company_executives) }
    let(:domain_entity) do
      double(
        :domain_entity,
        address: address,
        company_executives: company_executives,
        exchange_id: exchange_id,
        external_analysis: external_analysis,
        issuer_type_id: issuer_type_id,
        line_1: line_1
      )
    end
    let(:issuer_type_id) { double(:issuer_type_id) }
    let(:line_1) { double(:line_1) }

    subject { company_builder.build_full_company_from_domain(domain_entity) }

    before :each do
      expect(company_builder).to receive(:build).and_yield(builder)
      expect(builder).to receive(:build_base_entity_from_domain).with(domain_entity) { "Built with basic attributes" }
      expect(builder).to receive(:set_company_executives).with(company_executives) { "Built Executives" }
      expect(builder).to receive(:set_exchange_id).with(exchange_id) { "Built exchange_id" }
      expect(builder).to receive(:set_external_analysis).with(external_analysis) { "Built External Analysis" }
      expect(builder).to receive(:set_issuer_type_id).with(issuer_type_id) { "Built issuer_type_id" }
    end

    context "with line_1" do
      it "expect to build a full company object with address" do
        expect(builder).to receive(:set_address).with(address) { "Built Address" }

        subject
      end
    end

    context "without line_1" do
      let(:line_1) { nil }
      it "expect to build a full company object without address" do
        expect(builder).not_to receive(:set_address)

        subject
      end
    end
  end

  describe "#set_address" do
    let(:address_builder) { double(:address_builder) }
    subject { company_builder.set_address(db_address) }

    it "expect to build address and assign to company" do
      expect(AddressBuilder).to receive(:new).with(db_address) { address_builder }
      expect(address_builder).to receive(:build).and_yield(builder)
      expect(builder).to receive(:build_full_address_from_domain).with(db_address) { "Built with basic attributes" }

      subject
    end
  end

  describe "#set_company_executives" do
    let(:executive_name) { double(:executive_name) }
    let(:executives) { [executive] }
    let(:executive) { double(:executive, name: executive_name) }

    subject { company_builder.set_company_executives(executives) }

    context "without executives" do
      let(:executives) { nil }

      it "expect not to call to delete or update/add the executives" do
        expect(company_builder).not_to receive(:_delete_company_executives)
        expect(company_builder).not_to receive(:_update_or_add_company_executives)

        subject
      end
    end

    context "with executives" do
      let(:executive_builder) { double(:executive_builder) }

      context "executives needed to be deleted" do
        let(:executive_name) { db_executive_name }

        it "expect to add/update and nothing needed to be deleted" do
          expect(CompanyExecutiveBuilder).to receive(:new).with(db_executive) { executive_builder }
          expect(executive_builder).to receive(:build).and_yield(builder)
          expect(builder).to receive(:build_base_entity_from_domain).with(executive) { "Built Executive" }
          expect(company_builder).not_to receive(:_delete_company_executives)
          expect(company_builder).to receive(:_add_to_association).with("Built Executive") { "Added" }

          subject
        end
      end

      context "executives without needed to be deleted" do
        it "expect to add and delete the executives" do
          expect(CompanyExecutiveBuilder).to receive(:new).with(nil) { executive_builder }
          expect(executive_builder).to receive(:build).and_yield(builder)
          expect(builder).to receive(:build_base_entity_from_domain).with(executive) { "Built Executive" }
          expect(company_builder).to receive(:_delete_company_executives).with([db_executive_name]).and_call_original
          expect(company_builder).to receive(:_add_to_association).with("Built Executive") { "Added" }
          expect(db_executive).to receive(:mark_for_destruction)

          subject
        end
      end
    end
  end

  describe "#set_exchange_id" do
    subject { company_builder.set_exchange_id(100) }

    it "expect to assign issuer_type_id" do
      subject
      expect(db_entity.exchange_id).to eq 100
    end
  end

  describe "#set_external_analysis" do
    subject { company_builder.set_external_analysis("external_analysis") }

    it "expect to assign external analysis" do
      subject
      expect(JSON.parse(db_entity.external_analysis)).to eq "external_analysis"
    end
  end

  describe "#set_issuer_type_id" do
    subject { company_builder.set_issuer_type_id(100) }

    it "expect to assign issuer_type_id" do
      subject
      expect(db_entity.issuer_type_id).to eq 100
    end
  end
end
