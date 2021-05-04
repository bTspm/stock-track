require "rails_helper"

describe ExternalAnalysisStore do
  subject(:store) { described_class.new }

  describe "#by_company" do
    let(:company) { build(:entity_company) }
    let(:datetime) { double(:datetime) }
    let(:source_by_company_client) { double(:source_by_company_client) }
    let(:source_by_symbol_client) { double(:source_by_symbol_client) }
    let(:rating_source) { "Source" }
    subject { store.by_company(company) }

    before do
      stub_const("ExternalAnalysisStore::SOURCES_BY_COMPANY", ["source_by_company"])
      stub_const("ExternalAnalysisStore::SOURCES_BY_SYMBOL", ["source_by_symbol"])
      expect(Allocator).to receive(:public_send).with(:source_by_company_client) { source_by_company_client }
      expect(Allocator).to receive(:public_send).with(:source_by_symbol_client) { source_by_symbol_client }
      expect(DateTime).to receive(:now) { datetime }
      expect(Entities::ExternalAnalysis).to receive(:new).with(
        analyses: analyses,
        refreshed_at: datetime
      ) { "External Analysis" }
    end

    context "when rating client call is successful" do
      let(:analyses) { ["Analysis by Symbol", "Analysis by Company"] }

      it "expect to build rating" do
        expect(source_by_company_client).to receive(:rating_by_company).with(company) { "Analysis by Company" }
        expect(source_by_symbol_client).to receive(:rating_by_symbol).with(company.symbol) { "Analysis by Symbol" }
        expect(Rails).not_to receive(:logger)

        expect(subject).to eq "External Analysis"
      end
    end

    context "when rating client call is a failure" do
      let(:analyses) { ["Empty By Symbol Analysis", "Analysis by Company"] }
      let(:exception) { StandardError.new "Test Case" }
      let(:source_by_company_error) { "Analysis failed for client: source_by_company. Symbol: AAPL. Error: Test Case" }
      let(:source_by_symbol_error) { "Analysis failed for client: source_by_symbol. Symbol: AAPL. Error: Test Case" }

      context "when rating client call by symbol is a failure" do
        it "expect to return analysis for call by company and empty analysis for by symbol" do
          expect(source_by_company_client).to receive(:rating_by_company).with(company) { "Analysis by Company" }
          expect(source_by_symbol_client).to receive(:rating_by_symbol).with(company.symbol).and_raise(exception)
          expect(Rails).to receive_message_chain(:logger, :error).with(source_by_symbol_error)
          expect(
            Entities::ExternalAnalyses::Analysis
          ).to receive(:null_object_with_source).with("source_by_symbol") { "Empty By Symbol Analysis" }

          expect(subject).to eq "External Analysis"
        end
      end

      context "when rating client call by company is a failure" do
        let(:analyses) { ["Analysis by Symbol", "Empty By Company Analysis"] }

        it "expect to return analysis for call by symbol and empty analysis for by company" do
          expect(source_by_company_client).to receive(:rating_by_company).with(company).and_raise(exception)
          expect(source_by_symbol_client).to receive(:rating_by_symbol).with(company.symbol) { "Analysis by Symbol" }
          expect(Rails).to receive_message_chain(:logger, :error).with(source_by_company_error)
          expect(
            Entities::ExternalAnalyses::Analysis
          ).to receive(:null_object_with_source).with("source_by_company") { "Empty By Company Analysis" }

          expect(subject).to eq "External Analysis"
        end
      end

      context "when both rating calls; by symbol and by company are failures" do
        let(:analyses) { ["Empty By Symbol Analysis", "Empty By Company Analysis"] }

        let(:logger) { double(:logger) }

        it "expect to return empty analysis for both calls by company and by symbol" do
          expect(source_by_company_client).to receive(:rating_by_company).with(company).and_raise(exception)
          expect(source_by_symbol_client).to receive(:rating_by_symbol).with(company.symbol).and_raise(exception)
          expect(Rails).to receive(:logger).exactly(2).times { logger }
          expect(logger).to receive(:error).with(source_by_company_error)
          expect(logger).to receive(:error).with(source_by_symbol_error)
          expect(
            Entities::ExternalAnalyses::Analysis
          ).to receive(:null_object_with_source).with("source_by_symbol") { "Empty By Symbol Analysis" }
          expect(
            Entities::ExternalAnalyses::Analysis
          ).to receive(:null_object_with_source).with("source_by_company") { "Empty By Company Analysis" }

          expect(subject).to eq "External Analysis"
        end
      end
    end
  end
end
