require "rails_helper"

describe ApiClients do
  class DummyClass
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
