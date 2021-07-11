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

    describe "#average_rating_rank" do
      subject { presenter.average_rating_rank }

      context "when average_rating_rank is nil" do
        let(:external_analysis) { build :entity_external_analysis, analyses: [] }

        it { is_expected.to eq "N/A" }
      end

      context "when average_rating_rank has value" do
        it { is_expected.to eq 3.0 }
      end
    end

    describe "#average_rating_signal" do
      subject { presenter.average_rating_signal }

      context "when average_rating_signal is nil" do
        let(:external_analysis) { build :entity_external_analysis, analyses: [] }

        it { is_expected.to eq "N/A" }
      end

      context "when average_rating_signal has value" do
        it "expect to get the value from locale" do
          expect(I18n).to receive(:t).with("analysis_signal.hold") { "Hold" }

          expect(subject).to eq "Hold"
        end
      end
    end
  end
end
