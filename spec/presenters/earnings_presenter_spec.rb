require "rails_helper"

describe EarningsPresenter do
  describe ".scalar" do
    let(:earning) { build :entity_eps_surprise }
    subject(:presenter) { described_class::Scalar.new(earning, view_context) }

    describe "#actual" do
      subject { presenter.actual }

      context "when actual is nil" do
        let(:earning) { build :entity_eps_surprise, actual: nil }

        it { is_expected.to eq"N/A" }
      end

      context "when actual has value" do
        it "expect to call st_number_to_currency with actual" do
          expect(view_context).to receive(:st_number_to_currency).with(1.23) { "Actual" }

          expect(subject).to eq "Actual"
        end
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

        it { is_expected.to eq "N/A" }
      end

      context "when estimate has value" do
        it "expect to call st_number_to_currency with estimate" do
          expect(view_context).to receive(:st_number_to_currency).with(3.45) { "Estimate" }

          expect(subject).to eq "Estimate"
        end
      end
    end

    describe "#reported_quarter" do
      subject { presenter.reported_quarter }

      it { is_expected.to eq "Q1 - 2020" }
    end

    describe "#surprise" do
      subject { presenter.surprise }

      context "when surprise is nil" do
        let(:earning) { build :entity_eps_surprise, actual: nil }

        it { is_expected.to eq"N/A" }
      end

      context "when surprise has value" do
        it "expect to call st_number_to_currency with actual" do
          expect(view_context).to receive(:st_number_to_currency).with(-2.22) { "Curr" }
          expect(view_context).to receive(:content_color_by_value).with(content: "Curr", value: -2.22) { "Surprise" }

          expect(subject).to eq "Surprise"
        end
      end
    end

    describe "#surprise_percent" do
      subject { presenter.surprise_percent }

      context "when surprise_percent is nil" do
        let(:earning) { build :entity_eps_surprise, actual: nil }

        it { is_expected.to eq"N/A" }
      end

      context "when surprise_percent has value" do
        it "expect to call st_number_to_currency with actual" do
          expect(view_context).to receive(:st_number_to_percentage).with(-64.35) { "Percent" }
          expect(
            view_context
          ).to receive(:content_color_by_value).with(content: "Percent", value: -64.35) { "Surprise Percent" }

          expect(subject).to eq "Surprise Percent"
        end
      end
    end
  end

  describe ".enum" do
    let(:earning) { build :entity_eps_surprise }
    let(:earnings) { Array.wrap earning }
    subject(:presenter) { described_class::Enum.new(earnings, view_context) }

    describe "#chart_data" do
      subject { presenter.chart_data }

      it "expect to return array of actual, estimates and categories" do
        expect_any_instance_of(described_class::Scalar).to receive(:category) { "Category" }

        result = subject
        expect(result).to include(actual: [1.23])
        expect(result).to include(categories: ["Category"])
        expect(result).to include(estimated: [3.45])
      end
    end
  end
end
