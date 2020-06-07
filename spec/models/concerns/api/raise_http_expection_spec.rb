require "rails_helper"

describe Api::RaiseHttpException do
  let(:conn) do
    Faraday.new { |builder|
      builder.use described_class
      builder.adapter :test, stubs
    }
  end
  let(:response) { { error: "Error Message" } }
  let(:stubs) do
    Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get(url) { |_env| [status, {}, response] }
    end
  end
  let(:url) { "example_url" }

  describe "#get" do
    subject { conn.get(url) }

    context "status - 200" do
      let(:response) { "test response" }
      let(:status) { 200 }

      it "expect to parse response" do
        expect(subject.body).to eq "test response"
      end
    end

    described_class::ERROR_STATUS_MAPPING.each do |status, exception|
      context "status - #{status}" do
        let(:response) { { error: "Error Message In Hash" } }
        let(:status) { status }

        context "with error_response as hash" do
          it "expect to log and raise an error" do
            error_message = "#{status}, Error Message In Hash"
            expect(Rails).to receive_message_chain(:logger, :error).with("Error: http:/example_url: #{error_message}")
            expect { subject }.to raise_error exception, error_message
          end
        end

        context "without error_response as text" do
          let(:response) { "Error Message As Text" }

          it "expect to log and raise an error" do
            error_message = "#{status}, Error Message As Text"
            expect(Rails).to receive_message_chain(:logger, :error).with("Error: http:/example_url: #{error_message}")
            expect { subject }.to raise_error exception, error_message
          end
        end

        context "without error_response as text" do
          let(:response) { nil }

          it "expect to log and raise an error" do
            error_message = "#{status}, Something went wrong"
            expect(Rails).to receive_message_chain(:logger, :error).with("Error: http:/example_url: #{error_message}")
            expect { subject }.to raise_error exception, error_message
          end
        end
      end
    end
  end
end
