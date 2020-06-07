require "rails_helper"

describe Api::TwelveData::RaiseHttpException do
  let(:conn) do
    Faraday.new do |builder|
      builder.use described_class
      builder.adapter :test, stubs
    end
  end
  let(:status) { 200 }
  let(:stubs) do
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get(url) { |_env| [status, {}, response.to_json] }
    end
  end
  let(:url) { "example_url" }

  describe "#get" do
    subject { conn.get(url) }

    context "status - 200" do
      context "response error - data not found" do
        let(:response) { { status: "error", message: "Error Message", code: 404 } }

        it "expect to log and raise an error" do
          expect(Rails).to receive_message_chain(:logger, :error).with("Error: 404, http:/example_url: Error Message")
          expect { subject }.to raise_error ApiExceptions::NotFound, "Error Message"
        end
      end

      context "response success" do
        let(:response) { { status: "ok" }.with_indifferent_access }

        subject { JSON.parse(conn.get(url).body) }

        it "expect to return response" do
          expect(subject).to eq response
        end
      end
    end
  end
end
