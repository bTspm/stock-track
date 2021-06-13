require "rails_helper"

describe EarningsPresenter do
  describe ".scalar" do
    let(:earning) { build :entity_eps_surprise }
    subject(:presenter) { described_class::Scalar.new(earning, view_context) }

    describe "#actual" do
      subject { presenter.actual }

      context "when actual is nil" do
        let(:earning) { build :entity_eps_surprise, actual: nil }

        it { is_expected.to be_nil }
      end

      context "when actual has value" do
        it { is_expected.to eq 1.23 }
      end
    end

    describe "#category" do
      subject { presenter.category }

      it "expect to get quarter" do
        expect(view_context).to receive(:elements_in_single).with((["Q1", 2020])) { "Category" }

        expect(subject).to eq "Category"
      end
    end

    describe "#estimate" do
      subject { presenter.estimate }

      context "when estimate is nil" do
        let(:earning) { build :entity_eps_surprise, estimate: nil }

        it { is_expected.to be_nil }
      end

      context "when estimate has value" do
        it { is_expected.to eq 3.45 }
      end
    end
  end

  describe ".enum" do
    let(:earning) { build :entity_eps_surprise }
    let(:earnings) { Array.wrap earning }
    subject(:presenter) { described_class::Enum.new(earnings, view_context) }

    describe "#chart_data" do
      subject { JSON.parse(presenter.chart_data).with_indifferent_access }

      it "expect to return array of actual, estimates and categories" do
        expect_any_instance_of(described_class::Scalar).to receive(:actual) { "Actual" }
        expect_any_instance_of(described_class::Scalar).to receive(:category) { "Category" }
        expect_any_instance_of(described_class::Scalar).to receive(:estimate) { "Estimate" }

        result = subject
        expect(result).to include(actual: ["Actual"])
        expect(result).to include(categories: ["Category"])
        expect(result).to include(estimated: ["Estimate"])
      end
    end
  end
end
