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

  describe "#external_analysis_store" do
    let(:store) { ExternalAnalysisStore }
    subject { allocator.external_analysis_store }

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

  describe "#stats_store" do
    let(:store) { StatsStore }
    subject { allocator.stats_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end

  describe "#stock_store" do
    let(:store) { StockStore }
    subject { allocator.stock_store }

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

  describe "#watch_list_store" do
    let(:store) { WatchListStore }
    subject { allocator.watch_list_store }

    it "expect to initialize the store" do
      expect(store).to receive(:new).and_call_original

      expect(subject).to be_kind_of(store)
    end
  end
end
