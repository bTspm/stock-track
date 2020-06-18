require "rails_helper"

describe Allocator do
  subject(:allocator) { described_class.new }

  describe "#company_executive_store" do
    let(:store) { CompanyExecutiveStore }
    subject { allocator.company_executive_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end

  describe "#company_store" do
    let(:store) { CompanyStore }
    subject { allocator.company_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end

  describe "#earnings_store" do
    let(:store) { EarningsStore }
    subject { allocator.earnings_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end

  describe "#exchange_store" do
    let(:store) { ExchangeStore }
    subject { allocator.exchange_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end

  describe "#growth_store" do
    let(:store) { GrowthStore }
    subject { allocator.growth_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end

  describe "#issuer_type_store" do
    let(:store) { IssuerTypeStore }
    subject { allocator.issuer_type_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end

  describe "#news_store" do
    let(:store) { NewsStore }
    subject { allocator.news_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end

  describe "#quote_store" do
    let(:store) { QuoteStore }
    subject { allocator.quote_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end

  describe "#recommendation_trend_store" do
    let(:store) { RecommendationTrendStore }
    subject { allocator.recommendation_trend_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end

  describe "#stats_store" do
    let(:store) { StatsStore }
    subject { allocator.stats_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end

  describe "#time_series_store" do
    let(:store) { TimeSeriesStore }
    subject { allocator.time_series_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end

  describe Allocator::ApiClients do
    class DummyClass
      include Allocator::ApiClients
    end

    subject(:dummy_class) { DummyClass.new }

    describe "#finn_hub_client" do
      let(:client) { Api::FinnHub::Client }
      subject { dummy_class.finn_hub_client }

      it "expect to initialize the client" do
        expect(client).to receive(:new).and_call_original

        expect(subject).to be_kind_of(client)
      end
    end

    describe "#iex_client" do
      let(:client) { Api::Iex::Client }
      subject { dummy_class.iex_client }

      it "expect to initialize the client" do
        expect(client).to receive(:new).and_call_original

        expect(subject).to be_kind_of(client)
      end
    end

    describe "#twelve_data_client" do
      let(:client) { Api::TwelveData::Client }
      subject { dummy_class.twelve_data_client }

      it "expect to initialize the client" do
        expect(client).to receive(:new).and_call_original

        expect(subject).to be_kind_of(client)
      end
    end
  end
end
