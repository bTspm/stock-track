require "rails_helper"

describe Entities::ExternalAnalysis do
  let(:refreshed_at) { DateTime.new(2021, 01, 01) }

  describe ".from_json" do
    let(:analysis) { "analysis" }
    let(:json) { { analyses: [analysis], refreshed_at: refreshed_at }.to_json }
    subject { described_class.from_json(json) }

    it "expect to initialize external analysis" do
      expect(Entities::ExternalAnalyses::Analysis).to receive(:from_data_hash).with(analysis) { "Analysis" }
      expect(described_class).to receive(:new).with(analyses: ["Analysis"], refreshed_at: refreshed_at) { "External" }

      subject
    end
  end

  describe ".null_object" do
    subject { described_class.null_object }

    it "expect to initialize external analysis with no analyses" do
      expect(DateTime).to receive(:now) { "DateTime" }
      expect(described_class).to receive(:new).with(analyses: [], refreshed_at: "DateTime") { "External" }

      subject
    end
  end

  let(:analysis) { build :entity_external_analyses_analysis }
  let(:analyses) { [analysis] }
  subject(:external_analysis) { described_class.new(analyses: analyses, refreshed_at: refreshed_at) }

  describe "#initialize" do
    subject { external_analysis }

    it "expect to initialize" do
      expect(subject.analyses).to eq analyses
      expect(subject.refreshed_at).to eq refreshed_at
    end
  end

  describe "#average_rating_rank" do
    subject { external_analysis.average_rating_rank }

    context "when there are no rating_ranks in analysis" do
      let(:analysis) { build :entity_external_analyses_analysis, :no_rating_rank }

      it { is_expected.to be_nil }
    end

    context "when there are rating_ranks in analysis" do
      context "when partial rating_ranks are null" do
        let(:no_rating_analysis) { build :entity_external_analyses_analysis, :no_rating_rank }
        let(:analyses) { [analysis, no_rating_analysis] }

        it { is_expected.to eq 3.0 }
      end

      context "when all rating_ranks are available" do
        let(:analysis_with_different_rating) { build :entity_external_analyses_analysis, rating_rank: 5 }
        let(:analyses) { [analysis, analysis_with_different_rating] }

        it { is_expected.to eq 4.0 }
      end
    end
  end

  describe "#average_rating_signal" do
    subject { external_analysis.average_rating_signal }

    before { allow(external_analysis).to receive(:average_rating_rank) { average_rating_rank } }

    context "when there is no average_rating_rank" do
      let(:average_rating_rank) { nil }

      it { is_expected.to be_nil }
    end

    context "when there is average_rating_rank" do
      context "rank between 1 - 1.5" do
        let(:average_rating_rank) { 1.25 }

        it { is_expected.to eq :strong_buy }
      end

      context "rank between 1.51 - 2.25" do
        let(:average_rating_rank) { 2 }

        it { is_expected.to eq :buy }
      end

      context "rank between 2.26 - 3.25" do
        let(:average_rating_rank) { 3}

        it { is_expected.to eq :hold }
      end

      context "rank between 3.26 - 4.25" do
        let(:average_rating_rank) { 4 }

        it { is_expected.to eq :sell }
      end

      context "rank between 4.26 - 5" do
        let(:average_rating_rank) { 5 }

        it { is_expected.to eq :strong_sell }
      end

      context "rank not in defined range - 6" do
        let(:average_rating_rank) { 6 }

        it { is_expected.to eq :unknown }
      end
    end
  end

  describe "#data_available?" do
    subject { external_analysis.data_available? }

    context "with analyses" do
      it { is_expected.to be_truthy }
    end

    context "without analyses" do
      let(:analyses) { [] }

      it { is_expected.to be_falsey }
    end
  end

  describe "#total_analysts" do
    subject { external_analysis.total_analysts }

    context "when data available" do
      it { is_expected.to eq 100 }
    end

    context "when data not available" do
      let(:analyses) { [] }

      it { is_expected.to be_nil }
    end
  end
end
