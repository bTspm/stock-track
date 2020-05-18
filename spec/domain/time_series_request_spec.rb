require "rails_helper"

describe TimeSeriesRequest do
  let(:args) { {end_date_with_time: end_date, interval: interval, start_date_with_time: start_date, symbol: symbol} }
  let(:date) { DateTime.new(2020, 01, 01) }
  let(:end_date) { date }
  let(:interval) { double(:interval) }
  let(:start_date) { DateTime.new(2010, 01, 01) }
  let(:symbol) { double(:symbol) }

  subject(:time_series_request) { described_class.new(args) }

  before :each do
    allow(DateTime).to receive(:now) { date }
  end

  describe "#initialize" do
    it { is_expected.to be_kind_of described_class }

    context "properties" do
      context "with args" do
        it "expect to return object with properties" do
          result = time_series_request
          expect(result.end_date_with_time).to eq end_date
          expect(result.interval).to eq interval
          expect(result.start_date_with_time).to eq start_date
          expect(result.symbol).to eq symbol
        end
      end

      context "default args" do
        let(:default_end_date) { date.end_of_day }
        let(:default_start_date) { DateTime.new(2019, 12, 01).end_of_day }
        let(:end_date) { nil }
        let(:interval) { nil }
        let(:start_date) { nil }

        it "expect to return object with default properties" do
          result = subject
          expect(result.end_date_with_time).to eq default_end_date
          expect(result.interval).to eq described_class::DAY1
          expect(result.start_date_with_time).to eq default_start_date
          expect(result.symbol).to eq symbol
        end
      end
    end
  end

  describe "#to_options" do
    subject { time_series_request.to_options }

    it "expect to return a hash with options" do
      result = subject
      expect(result).to include(end_date_with_time: "2020-01-01 00:00:00")
      expect(result).to include(interval: interval)
      expect(result).to include(start_date_with_time: "2010-01-01 00:00:00")
      expect(result).to include(symbol: symbol)
    end
  end

  describe ".five_year" do
    let(:start_date) { DateTime.new(2014, 01, 01).end_of_day }
    let(:symbol) { double(:symbol) }

    subject { described_class.five_year(symbol) }

    it "expect to initialize a request" do
      result = subject
      expect(result.end_date_with_time).to eq date.end_of_day
      expect(result.interval).to eq described_class::DAY1
      expect(result.start_date_with_time).to eq start_date
      expect(result.symbol).to eq symbol
    end
  end
end
