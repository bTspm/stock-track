require "rails_helper"

describe Entities::Quote do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) do
    {
      change: change,
      change_percent: change_percent,
      high: high,
      price: price,
      volume: volume,
      low: low,
      open: open,
      previous_close: previous_close,
      source: source,
      updated_at: updated_at,
    }
  end
  let(:change) { double(:change) }
  let(:change_percent) { double(:change_percent) }
  let(:high) { double(:high) }
  let(:price) { double(:price) }
  let(:volume) { double(:volume) }
  let(:low) { double(:low) }
  let(:open) { double(:open) }
  let(:previous_close) { double(:previous_close) }
  let(:source) { double(:source) }
  let(:updated_at) { double(:updated_at) }
  let(:quote) { described_class.new(args) }

  describe ".from_iex_response" do
    let(:args) do
      {
        change: -1.83,
        change_percent: -0.00591,
        high: 307.9,
        price: 307.71,
        source: "Close",
        updated_at: converted_datetime,
        low: 300.21,
        open: 300.94,
        previous_close: 309.54,
        volume: 42_108_051
      }
    end
    let(:converted_datetime) { DateTime.new(2020, 0o1, 0o1, 0o0, 0o0, 0o0) }
    let!(:response) { json_fixture("/api_responses/iex/quote.json") }

    subject { described_class.from_iex_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end

  describe ".from_tradier_response" do
    let(:args) do
      {
        change: -1.57,
        change_percent: -1.24,
        high: 127.64,
        price: 125.28,
        source: :tradier,
        updated_at: converted_datetime,
        low: 125.08,
        open: 126.44,
        previous_close: 126.85,
        volume: 94_625_601
      }.with_indifferent_access
    end
    let(:converted_datetime) { DateTime.new(2020, 0o1, 0o1, 0o0, 0o0, 0o0) }
    let!(:response) { json_fixture("/api_responses/tradier/quote.json").dig(:quotes, :quote) }

    subject { described_class.from_tradier_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
