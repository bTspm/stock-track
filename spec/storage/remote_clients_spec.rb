require "rails_helper"

describe RemoteClients do
  class DummyClass
    extend RemoteClients
  end

  subject(:dummy_class) { DummyClass }

  describe "#bar_chart_client" do
    let(:client) { Scraper::BarChartClient }
    subject { dummy_class.bar_chart_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#company_index_client" do
    let(:client) { Elasticsearch::Client }
    subject { dummy_class.company_index_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new).with(url: "es_url") { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#cnn_client" do
    let(:client) { Scraper::CnnClient }
    subject { dummy_class.cnn_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#finn_hub_client" do
    let(:client) { Api::FinnHub::Client }
    subject { dummy_class.finn_hub_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#github_client" do
    let(:client) { Scraper::GithubClient }
    subject { dummy_class.github_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#iex_client" do
    let(:client) { Api::Iex::Client }
    subject { dummy_class.iex_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#robin_hood_client" do
    let(:client) { Scraper::RobinHoodClient }
    subject { dummy_class.robin_hood_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#the_street_client" do
    let(:client) { Scraper::TheStreetClient }
    subject { dummy_class.the_street_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#tip_ranks_client" do
    let(:client) { Scraper::TipRanksClient }
    subject { dummy_class.tip_ranks_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#trading_view_client" do
    let(:client) { Scraper::TradingViewClient }
    subject { dummy_class.trading_view_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#tradier_client" do
    let(:client) { Api::Tradier::Client }
    subject { dummy_class.tradier_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#twelve_data_client" do
    let(:client) { Api::TwelveData::Client }
    subject { dummy_class.twelve_data_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#we_bull_client" do
    let(:client) { Scraper::WeBullClient }
    subject { dummy_class.we_bull_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#wsj_client" do
    let(:client) { Scraper::WsjClient }
    subject { dummy_class.wsj_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end

  describe "#zacks_client" do
    let(:client) { Scraper::ZacksClient }
    subject { dummy_class.zacks_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end
end
