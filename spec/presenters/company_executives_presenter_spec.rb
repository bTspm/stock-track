require "rails_helper"

describe CompanyExecutivesPresenter do
  describe ".scalar" do
    let(:age) { double(:age) }
    let(:compensation) { 2_000 }
    let(:currency) { "ABC" }
    let(:since) { double(:since) }
    let(:object) do
      double(
        :object,
        age: age,
        compensation: compensation,
        currency: currency,
        since: since
      )
    end

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#age" do
      subject { presenter.age }

      context "without age" do
        let(:age) { nil }
        it { is_expected.to eq "N/A" }
      end

      context "with age" do
        it { is_expected.to eq age }
      end
    end

    describe "#compensation_with_currency" do
      subject { presenter.compensation_with_currency }

      context "without compensation and currency" do
        let(:compensation) { nil }
        let(:currency) { nil }
        it { is_expected.to eq "N/A" }
      end

      context "without currency" do
        let(:currency) { nil }
        it { is_expected.to eq "2,000" }
      end

      context "with compensation and currency" do
        it { is_expected.to eq "2,000 (ABC)" }
      end
    end

    describe "#since" do
      subject { presenter.since }

      context "without since" do
        let(:since) { nil }
        it { is_expected.to eq "N/A" }
      end

      context "with since" do
        it { is_expected.to eq since }
      end
    end
  end

  describe ".enum" do
    let(:name_1) { "XYZ" }
    let(:name_2) { "ABC" }
    let(:object_1) { double(:object, name: name_1) }
    let(:object_2) { double(:object, name: name_2) }
    let(:objects) { [object_1, object_2] }

    subject(:presenter) { described_class::Enum.new(objects, view_context, {}) }

    describe "#sorted_by_name" do
      subject { presenter.sorted_by_name }

      it { is_expected.to match_array [object_2, object_1] }
    end
  end
end
