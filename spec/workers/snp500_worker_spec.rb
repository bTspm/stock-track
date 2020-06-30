require "rails_helper"

describe Snp500Worker do
  # Snp500Worker as class
  describe "#perform" do
    let(:symbols) { %w[ABC] }
    let(:worker) { described_class.new }
    subject { worker.perform }

    it "expect to call service and create workers" do
      expect(CompanyService).to receive_message_chain(:new, :snp500_company_symbols) { symbols }
      expect(CompanyWorker).to receive(:perform_async).with("ABC") { "Worker" }

      subject
    end
  end

  # Snp500Worker as sidekiq worker
  describe "#perform_async" do
    subject { described_class.perform_async }
    it "expect to create a sidekiq worker" do
      expect { subject }.to change(described_class.jobs, :size).by(1)
    end
  end
end
