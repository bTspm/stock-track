require "rails_helper"

describe Entities::Quote do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) do
    {
     change: change,
     change_percent: change_percent,
     close: close,
     extended_change: extended_change,
     extended_change_percent: extended_change_percent,
     extended_price: extended_price,
     extended_time: extended_time,
     high: high,
     is_us_market_open: is_us_market_open,
     latest_price: latest_price,
     latest_source: latest_source,
     latest_update: latest_update,
     latest_volume: latest_volume,
     low: low,
     open: open,
     previous_close: previous_close,
     previous_volume: previous_volume,
     volume: volume
    }
  end
  let(:change) { double(:change) }
  let(:change_percent) { double(:change_percent) }
  let(:close) { double(:close) }
  let(:extended_change) { double(:extended_change) }
  let(:extended_change_percent) { double(:extended_change_percent) }
  let(:extended_price) { double(:extended_price) }
  let(:extended_time) { double(:extended_time) }
  let(:high) { double(:high) }
  let(:is_us_market_open) { double(:is_us_market_open) }
  let(:latest_price) { double(:latest_price) }
  let(:latest_source) { double(:latest_source) }
  let(:latest_update) { double(:latest_update) }
  let(:latest_volume) { double(:latest_volume) }
  let(:low) { double(:low) }
  let(:open) { double(:open) }
  let(:previous_close) { double(:previous_close) }
  let(:previous_volume) { double(:previous_volume) }
  let(:volume) { double(:volume) }

  describe ".from_iex_response" do
    let(:args) do
      {
       change: -1.83,
       change_percent: -0.00591,
       close: 307.71,
       extended_change: -1.06,
       extended_change_percent: -0.00344,
       extended_price: 306.65,
       extended_time: converted_datetime,
       high: 307.9,
       is_us_market_open: false,
       latest_price: 307.71,
       latest_source: "Close",
       latest_update: converted_datetime,
       latest_volume: 42108051,
       low: 300.21,
       open: 300.94,
       previous_close: 309.54,
       previous_volume: 39732269,
       volume: 42108051
      }
    end
    let(:converted_datetime) { DateTime.new(2020, 0o1, 0o1, 0o0, 0o0, 0o0) }
    let(:converted_date) { Date.new(2020, 0o1, 0o1) }
    let!(:response) { json_fixture("/api_responses/iex/quote.json") }

    subject { described_class.from_iex_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
