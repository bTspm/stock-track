require "rails_helper"

describe Api::FinnHub::RaiseHttpException do
  let(:conn) do
    Faraday.new do |builder|
      builder.use described_class
      builder.adapter :test, stubs
    end
  end
  let(:status) { 200 }
  let(:stubs) do
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get(url) { |_env| [status, {}, response] }
    end
  end
  let(:url) { "example_url" }

  describe "#get" do
    subject { conn.get(url) }

    context "status - 403" do
      let(:status) { 403 }

      context "response error - premium data" do
        let(:response) { "You don't have access to this resource." }

        it "expect to log and raise a premium data error" do
          error_message = "You don't have access to this resource."
          expect(Rails).to receive_message_chain(:logger, :error).with("Error: http:/example_url: #{error_message}")
          expect { subject }.to raise_error ApiExceptions::PremiumDataError, error_message
        end
      end

      context "when the response is auth failure" do
        let(:response) { "Auth Failure" }

        it "expect to log and raise a forbidden error" do
          error_message = "Auth Failure"
          expect(Rails).to receive_message_chain(:logger, :error).with("Error: http:/example_url: #{error_message}")
          expect { subject }.to raise_error ApiExceptions::Forbidden, error_message
        end
      end
    end

    context "response success" do
      let(:response) { "Response".to_json }

      it "expect to return response" do
        expect(subject.body).to eq response
      end
    end
  end
end
