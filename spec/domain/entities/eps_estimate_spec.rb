require "rails_helper"

describe Entities::EpsEstimate do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) do
    {
     analysts_count: analysts_count,
     average: average,
     date: date,
     high: high,
     low: low
    }
  end
  let(:analysts_count) { double(:analysts_count) }
  let(:average) { double(:average) }
  let(:date) { double(:date) }
  let(:high) { double(:high) }
  let(:low) { double(:low) }

  describe ".from_finn_hub_response" do
    let(:args) do
      {
       analysts_count: 4,
       average: 3.3405,
       date: converted_date,
       high: 3.444,
       low: 3.2046
      }
    end
    let(:converted_date) { Date.new(2022, 0o6, 30) }
    let!(:response) { json_fixture("/api_responses/finn_hub/eps_estimates.json").last }

    subject { described_class.from_finn_hub_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
