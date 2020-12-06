require "rails_helper"

describe BusinessService do
  let(:allocator) { double(:allocator) }
  let(:service) { described_class.new }

  describe "#engine" do
    subject { service.engine }

    it "expect to initialize the store" do
      expect(Allocator).to receive(:new) { allocator }

      expect(subject).to eq allocator
    end
  end

  describe "#company_executive_storage" do
    subject { service.company_executive_storage }

    it "expect to call engine and get the store" do
      expect(service).to receive(:engine) { allocator }
      expect(allocator).to receive(:company_executive_store) { "company_executive_storage" }

      expect(subject).to eq "company_executive_storage"
    end
  end

  describe "#company_storage" do
    subject { service.company_storage }

    it "expect to call engine and get the store" do
      expect(service).to receive(:engine) { allocator }
      expect(allocator).to receive(:company_store) { "company_storage" }

      expect(subject).to eq "company_storage"
    end
  end

  describe "#earnings_storage" do
    subject { service.earnings_storage }

    it "expect to call engine and get the store" do
      expect(service).to receive(:engine) { allocator }
      expect(allocator).to receive(:earnings_store) { "earnings_storage" }

      expect(subject).to eq "earnings_storage"
    end
  end

  describe "#exchange_storage" do
    subject { service.exchange_storage }

    it "expect to call engine and get the store" do
      expect(service).to receive(:engine) { allocator }
      expect(allocator).to receive(:exchange_store) { "exchange_storage" }

      expect(subject).to eq "exchange_storage"
    end
  end

  describe "#growth_storage" do
    subject { service.growth_storage }

    it "expect to call engine and get the store" do
      expect(service).to receive(:engine) { allocator }
      expect(allocator).to receive(:growth_store) { "growth_storage" }

      expect(subject).to eq "growth_storage"
    end
  end

  describe "#issuer_type_storage" do
    subject { service.issuer_type_storage }

    it "expect to call engine and get the store" do
      expect(service).to receive(:engine) { allocator }
      expect(allocator).to receive(:issuer_type_store) { "issuer_type_storage" }

      expect(subject).to eq "issuer_type_storage"
    end
  end

  describe "#news_storage" do
    subject { service.news_storage }

    it "expect to call engine and get the store" do
      expect(service).to receive(:engine) { allocator }
      expect(allocator).to receive(:news_store) { "news_storage" }

      expect(subject).to eq "news_storage"
    end
  end

  describe "#quote_storage" do
    subject { service.quote_storage }

    it "expect to call engine and get the store" do
      expect(service).to receive(:engine) { allocator }
      expect(allocator).to receive(:quote_store) { "quote_storage" }

      expect(subject).to eq "quote_storage"
    end
  end

  describe "#recommendation_trend_storage" do
    subject { service.recommendation_trend_storage }

    it "expect to call engine and get the store" do
      expect(service).to receive(:engine) { allocator }
      expect(allocator).to receive(:recommendation_trend_store) { "recommendation_trend_storage" }

      expect(subject).to eq "recommendation_trend_storage"
    end
  end

  describe "#stats_storage" do
    subject { service.stats_storage }

    it "expect to call engine and get the store" do
      expect(service).to receive(:engine) { allocator }
      expect(allocator).to receive(:stats_store) { "stats_storage" }

      expect(subject).to eq "stats_storage"
    end
  end

  describe "#time_series_storage" do
    subject { service.time_series_storage }

    it "expect to call engine and get the store" do
      expect(service).to receive(:engine) { allocator }
      expect(allocator).to receive(:time_series_store) { "time_series_storage" }

      expect(subject).to eq "time_series_storage"
    end
  end

  describe "#watch_list_storage" do
    subject { service.watch_list_storage }

    it "expect to call engine and get the store" do
      expect(service).to receive(:engine) { allocator }
      expect(allocator).to receive(:watch_list_store) { "watch_list_storage" }

      expect(subject).to eq "watch_list_storage"
    end
  end
end
