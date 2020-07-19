require "rails_helper"

describe RemoteClients do
  class DummyClass
    include RemoteClients
  end

  subject(:dummy_class) { DummyClass }

  describe "#company_index_client" do
    let(:client) { Elasticsearch::Client }
    subject { dummy_class.company_index_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new).with(url: "es_url") { "Client" }

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

  describe "#twelve_data_client" do
    let(:client) { Api::TwelveData::Client }
    subject { dummy_class.twelve_data_client }

    it "expect to initialize the client" do
      expect(client).to receive(:new) { "Client" }

      expect(subject).to eq "Client"
    end
  end
end
