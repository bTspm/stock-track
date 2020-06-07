require "rails_helper"

describe RecommendationTrendsPresenter do
  describe ".scalar" do
    let(:date) { Date.new(2020, 0o5, 0o1) }
    let(:object) { double(:object, date: date) }

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#formatted_month_with_year" do
      subject { presenter.formatted_month_with_year }

      it { is_expected.to eq "May<br>2020" }
    end
  end

  describe ".enum" do
    let(:args) do
      {
       buy: buy,
       date: date,
       hold: hold,
       sell: sell,
       strong_buy: strong_buy,
       strong_sell: strong_sell
      }
    end
    let(:buy) { 100 }
    let(:date) { Date.new(2020, 0o1, 0o1) }
    let(:object) { double(:object, args) }
    let(:hold) { 200 }
    let(:sell) { 300 }
    let(:strong_buy) { 400 }
    let(:strong_sell) { 500 }

    let(:args_1) do
      {
       buy: buy_1,
       date: date_1,
       hold: hold_1,
       sell: sell_1,
       strong_buy: strong_buy_1,
       strong_sell: strong_sell_1
      }
    end
    let(:buy_1) { 1_000 }
    let(:date_1) { Date.new(2021, 0o1, 0o1) }
    let(:hold_1) { 2_000 }
    let(:sell_1) { 3_000 }
    let(:strong_buy_1) { 4_000 }
    let(:strong_sell_1) { 5_000 }
    let(:object_1) { double(:object_1, args_1) }
    let(:objects) { [object, object_1] }

    subject(:presenter) { described_class::Enum.new(objects, view_context) }

    describe "#chart_data" do
      subject { JSON.parse(presenter.chart_data).deep_symbolize_keys }

      context "values" do
        it "expected to return chart data" do
          result = subject
          expect(result[:categories]).to eq %w(Jan<br>2020 Jan<br>2021)
          expect(result[:series]).to eq [{ data: [strong_buy, strong_buy_1], name: "Strong Buy" },
                                         { data: [buy, buy_1], name: "Buy" },
                                         { data: [hold, hold_1], name: "Hold" },
                                         { data: [sell, sell_1], name: "Sell" },
                                         { data: [strong_sell, strong_sell_1], name: "Strong Sell" }]
        end
      end

      context "count" do
        let(:objects) do
          [
           object,
           object_1,
           generate_object(args: args, increment: 10),
           generate_object(args: args, increment: 20),
           generate_object(args: args, increment: 30),
           generate_object(args: args, increment: 40)
          ]
        end

        it "expected to return chart data without the 1st date" do
          result = subject
          expect(result[:categories]).not_to include "Jan<br>2020"
          expect(result[:series].find { |a| a[:name] == "Strong Buy" }[:data]).not_to include strong_buy
          expect(result[:series].find { |a| a[:name] == "Buy" }[:data]).not_to include buy
          expect(result[:series].find { |a| a[:name] == "Hold" }[:data]).not_to include hold
          expect(result[:series].find { |a| a[:name] == "Sell" }[:data]).not_to include sell
          expect(result[:series].find { |a| a[:name] == "Strong Sell" }[:data]).not_to include strong_sell
        end
      end
    end

    def generate_object(args:, increment: 1)
      args = args.transform_values { |v| v * increment rescue nil }
      args[:date] = Date.new(2025, 0o1, 0o1) + increment.years
      OpenStruct.new(args)
    end
  end
end
