require "rails_helper"

describe Entities::Growth do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) do
    {
      day_30: day_30,
      day_5: day_5,
      max: max,
      month_1: month_1,
      month_3: month_3,
      month_6: month_6,
      year_1: year_1,
      year_2: year_2,
      year_5: year_5,
      ytd: ytd
    }
  end
  let(:day_30) { double(:day_30) }
  let(:day_5) { double(:day_5) }
  let(:max) { double(:max) }
  let(:month_1) { double(:month_1) }
  let(:month_3) { double(:month_3) }
  let(:month_6) { double(:month_6) }
  let(:year_1) { double(:year_1) }
  let(:year_2) { double(:year_2) }
  let(:year_5) { double(:year_5) }
  let(:ytd) { double(:ytd) }

  describe ".from_iex_response" do
    let(:args) do
      {
        day_30: 27.46,
        day_5: -2.32,
        max: 30366.340000000004,
        month_1: 8.18,
        month_3: -3.54,
        month_6: 15.78,
        year_1: 61.17,
        year_2: 65.05,
        year_5: 138.96,
        ytd: 3.8699999999999997
      }
    end
    let!(:response) { json_fixture("/api_responses/iex/stats.json") }

    subject { described_class.from_iex_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
