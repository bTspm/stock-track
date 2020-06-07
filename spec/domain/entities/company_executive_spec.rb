require "rails_helper"

describe Entities::CompanyExecutive do
  it_behaves_like "Entities::BaseEntity#initialize"
  it_behaves_like "Entities::DbEntity.from_db_entity"

  let(:args) do
    {
     age: age,
     compensation: compensation,
     currency: currency,
     name: name,
     since: since,
     titles: titles
    }
  end
  let(:age) { double(:age) }
  let(:compensation) { double(:compensation) }
  let(:currency) { double(:currency) }
  let(:name) { double(:name) }
  let(:since) { double(:since) }
  let(:titles) { double(:titles) }

  subject(:company_executive) { described_class.new(args) }

  context "properties" do
    context "when titles are nil" do
      let(:titles) { nil }

      subject { company_executive.titles }
      it { is_expected.to match_array [] }
    end
  end

  describe ".from_finn_hub_response" do
    let(:args) do
      {
       age: 59,
       compensation: 11555466,
       currency: "USD",
       name: "Mr. Timothy Cook",
       since: "2011",
       titles: ["Chief Executive Officer", "Director"]
      }
    end
    let!(:response) { json_fixture("/api_responses/finn_hub/executives.json").last }

    subject(:company_executive) { described_class.from_finn_hub_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end

    context "titles" do
      subject { company_executive.titles }
      context "without position" do
        let(:response) { json_fixture("/api_responses/finn_hub/executives.json").last.merge(position: nil) }
        it { is_expected.to match_array [] }
      end
    end
  end
end
