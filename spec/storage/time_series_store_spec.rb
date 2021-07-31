require "rails_helper"

describe TimeSeriesStore do
  let(:cache_key) { "key" }
  let(:domain_class) { Entities::TimeSeries }
  subject(:store) { described_class.new }

  before do
    Rails.cache.clear
    allow_any_instance_of(described_class).to receive(:fetch_cached).with(key: cache_key).and_call_original
  end

  describe "#by_symbol_from_tradier" do
    let(:cache_key) { "TimeSeriesStore/by_symbol_from_tradier/options" }
    let(:options) { "options" }
    let(:response) { double(:response, body: { history: { day: [time_series_response] } }) }
    let(:time_series_response) { double(:time_series_response) }
    subject { store.by_symbol_from_tradier(options) }

    it "expect to call time_series and build growth" do
      expect(Allocator).to receive_message_chain(:tradier_client, :time_series).with(options) { response }
      expect(domain_class).to receive(:from_tradier_response).with(time_series_response) { "TimeSeries Domain" }

      expect(subject).to eq ["TimeSeries Domain"]
    end
  end
end
