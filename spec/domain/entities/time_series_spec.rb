require "rails_helper"

describe Entities::TimeSeries do
  it_behaves_like "Entities::BaseEntity#initialize"

  let(:args) do
    {
     close: close,
     datetime: datetime,
     high: high,
     low: low,
     open: open,
     volume: volume,
    }
  end
  let(:close) { double(:close) }
  let(:datetime) { double(:datetime) }
  let(:high) { double(:high) }
  let(:low) { double(:low) }
  let(:open) { double(:open) }
  let(:volume) { double(:volume) }

  describe ".from_twelve_data_response" do
    let(:args) do
      {
       close: 180.53000,
       datetime: converted_datetime,
       high: 180.69000,
       low: 175.67999,
       open: 177.53999,
       volume: 41818400
      }
    end
    let(:converted_datetime) { DateTime.new(2020, 0o5, 14, 0o0, 0o0, 0o0) }
    let!(:response) { json_fixture("/api_responses/twelve_data/time_series.json").last }

    subject { described_class.from_twelve_data_response(response) }

    it "expect to create an entity with args" do
      expect(described_class).to receive(:new).with(args)

      subject
    end
  end
end
