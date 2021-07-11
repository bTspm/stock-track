require "rails_helper"

describe ExternalAnalyses::AnalysesPresenter do
  describe ".scalar" do
    let(:analysis) { build :entity_external_analyses_analysis }
    subject(:presenter) { described_class::Scalar.new(analysis, view_context) }

    describe "#chart_data" do
      subject { presenter.chart_data }

      context "when price_target is available" do
        it "expect to return chart data" do
          expect(presenter).to receive(:formatted_source) { "Source" }

          expect(subject).to include(name: "Source", data: [100, 150, 200])
        end
      end

      context "when price_target is not available" do
        let(:analysis) { build :entity_external_analyses_analysis, :no_price_target }

        it { is_expected.to be_nil }
      end
    end

    describe "#formatted_original_rating" do
      subject { presenter.formatted_original_rating }

      context "when original_rating is available" do
        it { is_expected.to eq "Strong Buy" }
      end

      context "when original_rating is not available" do
        let(:analysis) { build :entity_external_analyses_analysis, :no_original_rating }

        it { is_expected.to eq "N/A" }
      end
    end

    describe "#formatted_source" do
      subject { presenter.formatted_source }

      it { is_expected.to eq "We Bull" }
    end

    describe "#price_target" do
      subject { presenter.price_target }

      context "when analysis does not have price_target" do
        let(:analysis) { build :entity_external_analyses_analysis, price_target: nil }

        it { is_expected.to be_nil }
      end

      context "when analysis has price_target" do
        it "expect to return exchange presenter" do
          expect(
            ExternalAnalyses::PriceTargetPresenter
          ).to receive(:present).with(analysis.price_target, view_context) { "Price Target" }

          expect(subject).to eq "Price Target"
        end
      end
    end
  end

  describe ".enum" do
    let(:analysis) { build :entity_external_analyses_analysis }
    let(:analyses) { [analysis] }
    subject(:presenter) { described_class::Enum.new(analyses, view_context) }

    describe "#custom_analyses_sorted_by_source_asc" do
      subject { presenter.custom_analyses_sorted_by_source_asc }

      context "analyses with no custom" do
        let(:analysis) { build :entity_external_analyses_analysis, custom: nil }

        it { is_expected.to eq [] }
      end

      context "analyses with custom" do
        let(:analysis_z) { build :entity_external_analyses_analysis, source: "z", custom: "Custom" }
        let(:analysis_a) { build :entity_external_analyses_analysis, source: "a", custom: "Custom" }
        let(:analyses) { [analysis_z, analysis_a] }

        it { is_expected.to eq [analysis_a, analysis_z] }
      end
    end

    describe "#ordered_by_source_asc_with_no_ratings_last" do
      let(:analysis_with_rating) { build :entity_external_analyses_analysis, source: "z" }
      let(:analysis_without_rating) { build :entity_external_analyses_analysis, :no_original_rating, source: "a" }
      let(:analyses) { [analysis_without_rating, analysis_with_rating] }
      subject { presenter.ordered_by_source_asc_with_no_ratings_last }

      it { is_expected.to eq [analysis_with_rating, analysis_without_rating] }
    end

    describe "#price_targets_chart_data" do
      let(:analysis_scalar) { double(:analysis_scalar) }
      subject { presenter.price_targets_chart_data }

      it "expect to call chart_data on analysis" do
        expect(described_class).to receive(:present).with(analysis, view_context, {}) { analysis_scalar }
        expect(analysis_scalar).to receive(:chart_data) { "Chart Data" }

        expect(subject).to eq ["Chart Data"]
      end
    end

    describe "#with_price_targets" do
      subject { presenter.with_price_targets }

      context "analyses with no price_target" do
        let(:analysis) { build :entity_external_analyses_analysis, price_target: nil }

        it { is_expected.to eq [] }
      end

      context "analyses with price_target" do
        it { is_expected.to eq [analysis] }
      end
    end
  end
end
