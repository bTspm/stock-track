require "rails_helper"

describe Api::TwelveData::Client do
  let!(:conn) { double(:conn) }

  subject(:client) { described_class.new }

  before { allow(Faraday).to receive(:new) { conn } }

  describe "#time_series" do
    let(:end_datetime) { "end" }
    let(:options) do
      {
        end_datetime: end_datetime,
        interval: "1day",
        start_datetime: start_datetime,
        symbol: "ABC"
      }
    end
    let(:start_datetime) { "start" }

    subject { client.time_series(options) }

    context "without start and end datetime" do
      let(:end_datetime) { nil }
      let(:start_datetime) { nil }

      it "expect to get time_series without the end and start date" do
        expect(client).to receive(:get).with(
          "https://api.twelvedata.com/time_series?symbol=ABC&interval=1day&apikey=api_key"
        ) { "Time Series" }

        expect(subject).to eq "Time Series"
      end
    end

    context "with start and end datetime" do
      it "expect to get time_series" do
        expect(client).to receive(:get).with(
          "https://api.twelvedata.com/time_series?symbol=ABC&interval=1day&start_date=start&end_date=end&apikey=api_key"
        ) { "Time Series" }

        expect(subject).to eq "Time Series"
      end
    end
  end
end
