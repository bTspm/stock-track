require "rails_helper"

describe Entities::EpsSurprise do
  it_behaves_like 'Entities::BaseEntity#initialize'

  let(:args) { {actual: actual, date: date, estimate: estimate} }
  let(:actual) { double(:actual) }
  let(:date) { double(:date) }
  let(:estimate) { double(:estimate) }

  describe ".from_finn_hub_response" do
    let(:args) { {actual: 4.99, date: converted_date, estimate: 4.641} }
    let(:converted_date) { Date.new(2019, 12, 31) }
    let!(:response) { json_fixture("/api_responses/finn_hub/earnings.json").last }

    subject { described_class.from_finn_hub_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
