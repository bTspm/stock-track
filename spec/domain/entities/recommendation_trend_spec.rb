require "rails_helper"

describe Entities::RecommendationTrend do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) do
    {
     buy: buy,
     date: date,
     hold: hold,
     sell: sell,
     strong_buy: strong_buy,
     strong_sell: strong_sell
    }
  end
  let(:buy) { double(:buy) }
  let(:date) { "2020-01-01" }
  let(:hold) { double(:hold) }
  let(:sell) { double(:sell) }
  let(:strong_buy) { double(:strong_buy) }
  let(:strong_sell) { double(:strong_sell) }

  describe ".from_finn_hub_response" do
    let(:args) do
      {
       buy: 16,
       date: converted_date,
       hold: 9,
       sell: 2,
       strong_buy: 13,
       strong_sell: 0
      }
    end
    let(:converted_date) { Date.new(2020, 04, 01) }
    let!(:response) { json_fixture("/api_responses/finn_hub/recommendation_trends.json").last }

    subject { described_class.from_finn_hub_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
