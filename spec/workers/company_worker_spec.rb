require "rails_helper"

describe CompanyWorker do
  let(:symbol) { double(:symbol) }

  # CompanyWorker as class
  describe "#perform" do
    let(:worker) { described_class.new }
    subject { worker.perform(symbol) }

    it "expect to call service and save company" do
      expect(CompanyService).to receive_message_chain(:new, :save_company_by_symbol).with(symbol) { "Saved" }

      subject
    end
  end

  # CompanyWorker as sidekiq worker
  describe "#perform_async" do
    subject { described_class.perform_async(symbol) }
    it "expect to create a sidekiq worker" do
      expect { subject }.to change(described_class.jobs, :size).by(1)
    end
  end
end
