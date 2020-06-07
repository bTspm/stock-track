require "rails_helper"

describe TimeSeriesPresenter do
  describe ".scalar" do
    let(:args) { { close: 100, datetime: DateTime.new(2020, 05, 01) } }
    let(:object) { double(:object, args) }

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#formatted_chart_data" do
      subject { presenter.formatted_chart_data }

      it { is_expected.to eq [1588291200000, 100] }
    end
  end

  describe ".enum" do
    let(:args) { { close: 200, datetime: DateTime.new(2020, 05, 01) } }
    let(:args_1) { { close: 100, datetime: DateTime.new(2030, 05, 01) } }
    let(:object) { double(:object, args) }
    let(:object_1) { double(:object_1, args_1) }
    let(:objects) { [object, object_1] }
    let(:symbol) { "abc" }

    subject(:presenter) { described_class::Enum.new(objects, view_context) }

    describe "#chart_data" do
      subject { JSON.parse(presenter.chart_data(symbol)).with_indifferent_access }

      it "expect to return chart data" do
        result = subject
        expect(result[:stock_data]).to eq [[1588291200000, 200], [1903824000000, 100]]
        expect(result[:subtitle]).to eq "Between May 01, 2020 to May 01, 2030"
        expect(result[:symbol]).to eq "ABC"
        expect(result[:time_line_buttons]).to eq [{ "type" => "week", "count" => 1, "text" => "1w" },
                                                  { "type" => "month", "count" => 1, "text" => "1m" },
                                                  { "type" => "month", "count" => 3, "text" => "3m" },
                                                  { "type" => "month", "count" => 6, "text" => "6m" },
                                                  { "type" => "ytd", "text" => "YTD" },
                                                  { "type" => "year", "count" => 1, "text" => "1y" },
                                                  { "type" => "year", "count" => 5, "text" => "5y" },
                                                  { "type" => "all", "text" => "All" }]
        expect(result[:title]).to eq "ABC Stock QuotePrice"
      end
    end
  end
end
