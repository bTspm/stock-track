require "rails_helper"

describe AddressesPresenter do
  describe ".scalar" do
    let(:city) { "City" }
    let(:country) { "Country" }
    let(:line_1) { "Line 1" }
    let(:line_2) { "Line 2" }
    let(:state) { "State" }
    let(:zip_code) { 12_345 }
    let(:object) do
      double(
        :object,
        city: city,
        country: country,
        line_1: line_1,
        line_2: line_2,
        state: state,
        zip_code: zip_code
      )
    end

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#formatted" do
      subject { presenter.formatted }

      context "without address" do
        let(:object) { nil }
        it { is_expected.to eq "N/A" }
      end

      context "with address" do
        context "with out line_1" do
          let(:line_1) { nil }
          it { is_expected.not_to include "Line 1" }
        end

        context "with out line_2" do
          let(:line_2) { nil }
          it { is_expected.not_to include "Line 2" }
        end

        context "with out city" do
          let(:city) { nil }
          it { is_expected.not_to include "City" }
        end

        context "with out state" do
          let(:state) { nil }
          it { is_expected.not_to include "State" }
        end

        context "with out country" do
          let(:country) { nil }
          it { is_expected.not_to include "Country" }
        end

        context "with out zip_code" do
          let(:zip_code) { nil }
          it { is_expected.not_to include "12345" }
        end
      end
    end
  end
end
