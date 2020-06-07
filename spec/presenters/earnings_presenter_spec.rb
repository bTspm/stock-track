require "rails_helper"

describe EarningsPresenter do
  describe ".scalar" do
    let(:eps_estimate_1_average) { 100 }
    let(:eps_estimate_1_date) { Date.new(2020, 10, 01) }
    let(:eps_estimate_1) { double(:eps_estimate_1, average: eps_estimate_1_average, date: eps_estimate_1_date) }
    let(:eps_estimate_2_average) { 200 }
    let(:eps_estimate_2_date) { Date.new(2020, 07, 01) }
    let(:eps_estimate_2) { double(:eps_estimate_2, average: eps_estimate_2_average, date: eps_estimate_2_date) }
    let(:eps_estimates) { [eps_estimate_1, eps_estimate_2] }
    let(:eps_surprise_1_actual) { 1_000 }
    let(:eps_surprise_1_date) { Date.new(2020, 01, 01) }
    let(:eps_surprise_1_estimate) { 3_000 }
    let(:eps_surprise_1) do
      double(
       :eps_surprise_1,
       actual: eps_surprise_1_actual,
       date: eps_surprise_1_date,
       estimate: eps_surprise_1_estimate
      )
    end
    let(:eps_surprise_2_actual) { 2_000 }
    let(:eps_surprise_2_date) { Date.new(2020, 04, 01) }
    let(:eps_surprise_2_estimate) { 4_000 }
    let(:eps_surprise_2) do
      double(
       :eps_surprise_2,
       actual: eps_surprise_2_actual,
       date: eps_surprise_2_date,
       estimate: eps_surprise_2_estimate
      )
    end
    let(:eps_surprises) { [eps_surprise_1, eps_surprise_2] }
    let(:object) { { eps_estimates: eps_estimates, eps_surprises: eps_surprises } }

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#chart_data" do
      subject { JSON.parse(presenter.chart_data).with_indifferent_access }

      context "without eps_estimates" do
        let(:eps_estimates) { nil }
        it "expect to return chart data" do
          result = subject
          expect(result[:actual]).to match_array [eps_surprise_1_actual, eps_surprise_2_actual]
          expect(result[:categories]).to match_array %w(Q1<br>2020 Q2<br>2020)
          expect(result[:estimated]).to match_array [eps_surprise_1_estimate, eps_surprise_2_estimate]
        end
      end

      context "with eps_estimates" do
        it "expect to return chart data" do
          result = subject
          expect(result[:actual]).to match_array [eps_surprise_1_actual, eps_surprise_2_actual]
          expect(result[:categories]).to match_array %w(Q1<br>2020 Q2<br>2020 Q3<br>2020 Q4<br>2020)
          expect(result[:estimated]).to match_array [eps_estimate_1_average,
                                                     eps_estimate_2_average,
                                                     eps_surprise_1_estimate,
                                                     eps_surprise_2_estimate]
        end
      end

      context "Max of 2 Estimates" do
        let(:eps_estimate_3_average) { 300 }
        let(:eps_estimate_3_date) { Date.new(3030, 07, 01) }
        let(:eps_estimate_3) { double(:eps_estimate_3, average: eps_estimate_3_average, date: eps_estimate_3_date) }
        let(:eps_estimates) { [eps_estimate_1, eps_estimate_2, eps_estimate_3] }
        it "expect to return estimates only 2" do
          expect(subject[:estimated]).not_to include eps_estimate_3_average
        end
      end

      context "Max of 4 Surprises" do
        let(:eps_surprise_3_actual) { 3_000 }
        let(:eps_surprise_3_date) { eps_surprise_2_date + 3.months }
        let(:eps_surprise_3_estimate) { 6_000 }
        let(:eps_surprise_3) do
          double(
           :eps_surprise_3,
           actual: eps_surprise_3_actual,
           date: eps_surprise_3_date,
           estimate: eps_surprise_3_estimate
          )
        end

        let(:eps_surprise_4_actual) { 4_000 }
        let(:eps_surprise_4_date) { eps_surprise_3_date + 3.months }
        let(:eps_surprise_4_estimate) { 8_000 }
        let(:eps_surprise_4) do
          double(
           :eps_surprise_4,
           actual: eps_surprise_4_actual,
           date: eps_surprise_4_date,
           estimate: eps_surprise_4_estimate
          )
        end

        let(:eps_surprise_5_actual) { 5_000 }
        let(:eps_surprise_5_date) { eps_surprise_4_date + 3.months }
        let(:eps_surprise_5_estimate) { 10_000 }
        let(:eps_surprise_5) do
          double(
           :eps_surprise_5,
           actual: eps_surprise_5_actual,
           date: eps_surprise_5_date,
           estimate: eps_surprise_5_estimate
          )
        end

        let(:eps_surprises) { [eps_surprise_1, eps_surprise_2, eps_surprise_3, eps_surprise_4, eps_surprise_5] }

        it "expect to only last 4 surprises" do
          result = subject
          expect(result[:actual]).not_to include eps_estimate_1_average
          expect(result[:categories]).not_to include "Q1<br>2020"
          expect(result[:estimated]).not_to include eps_surprise_1_estimate
        end
      end

      context "Estimates are greater than Surprises" do
        let(:eps_estimate_3_average) { 300 }
        let(:eps_estimate_3_date) { eps_surprise_2_date - 10.years }
        let(:eps_estimate_3) { double(:eps_estimate_3, average: eps_estimate_3_average, date: eps_estimate_3_date) }
        let(:eps_estimates) { [eps_estimate_1, eps_estimate_2, eps_estimate_3] }

        it "expect to return estimates which are greater than last date of surprise" do
          expect(subject[:estimated]).not_to include eps_estimate_3_average
        end
      end
    end
  end
end
