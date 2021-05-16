require "rails_helper"

describe ExternalAnalysisHelper do

  describe "#source_with_external_link" do
    let(:analysis) do
      double(
        :analysis,
        original_rating: original_rating,
        formatted_source: formatted_source,
        url: url
      )
    end
    let(:original_rating) { "Buy" }
    let(:formatted_source) { "Cnn" }
    let(:url) { "example.com" }
    subject { helper.source_with_external_link(analysis) }

    context "when url is blank" do
      let(:url) { nil }

      it { is_expected.to eq "Cnn" }
    end

    context "when original_rating_is blank" do
      let(:original_rating) { nil }

      it { is_expected.to eq "Cnn" }
    end

    context "when both original_rating and url are blank" do
      let(:original_rating) { nil }
      let(:url) { nil }

      it { is_expected.to eq "Cnn" }
    end

    context "when both original_rating and url are present" do
      it "expect to return source with the external link and icon" do
        expect(subject).to include "fas fa-external-link-alt"
        expect(subject).to include "Navigate to Cnn"
      end
    end
  end
end
