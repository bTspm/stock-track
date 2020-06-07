require "rails_helper"

describe Api::Response do
  let(:body) { "Body" }
  let(:headers) { double(:headers) }
  let(:response_object) do
    double(
      :response,
      body: body,
      headers: headers,
      status: status,
      success?: success
    )
  end
  let(:status) { double(:status) }
  let(:success) { double(:success) }

  subject(:response) { described_class.new(response_object) }

  describe "#initialize" do
    it "expect to respond to attributes" do
      result = response
      expect(result.headers).to eq headers
      expect(result.status).to eq status
      expect(result.success).to eq success
    end

    context "body" do
      subject { response.body }

      context "body as array" do
        let(:body) { [1, 2] }

        it { is_expected.to eq [1, 2] }
      end

      context "body as hash" do
        let(:body) { { a: "b" } }

        it { is_expected.to include(a: "b") }
      end

      context "body as string" do
        it { is_expected.to eq "Body" }
      end
    end
  end
end
