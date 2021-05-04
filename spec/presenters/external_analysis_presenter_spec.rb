require "rails_helper"

describe ExternalAnalysisPresenter do
  describe ".scalar" do
    let(:external_analysis) { build :entity_external_analysis }
    subject(:presenter) { described_class::Scalar.new(external_analysis, view_context) }

    describe "#formatted_refreshed_at" do
      subject { presenter.formatted_refreshed_at }

      it "expect to return last refreshed at" do
        expect(view_context).to receive(:time_ago) { "5 min ago" }

        expect(subject).to eq "Refreshed: 5 min ago"
      end
    end

    describe "#analyses" do
      subject { presenter.analyses }

      it "expect to return external_analysis presenter" do
        expect(
          ExternalAnalyses::AnalysesPresenter
        ).to receive(:present).with(external_analysis.analyses, view_context) { "Analysis" }

        expect(subject).to eq "Analysis"
      end
    end
  end
end
