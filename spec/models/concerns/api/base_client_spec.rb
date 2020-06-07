require "rails_helper"

describe Api::BaseClient do
  let(:conn) { Faraday.new { |builder| builder.adapter :test, stubs } }
  let(:stubs) do
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get(url) { |_env| [200, {}, response] }
    end
  end
  let(:url) { "example_url" }

  subject(:client) { described_class.new }

  before :each do
    allow(Faraday).to receive(:new).and_return(conn)
  end

  describe "#initialize" do
    it "expect to init a Faraday connection" do
      expect(Faraday).to receive(:new) { conn }

      client
    end
  end

  describe "#get" do
    let(:response) { "Response" }
    subject { client.get(url) }

    it "expect to init a Response" do
      expect(conn).to receive(:get).with(url) { response }
      expect(Api::Response).to receive(:new).with(response) { "Parsed Response" }

      subject
    end
  end
end
