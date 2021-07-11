require "rails_helper"

describe TimeSeriesPresenter do
  describe ".scalar" do
    let(:args) { { close: 100, datetime: DateTime.new(2020, 0o5, 0o1) } }
    let(:object) { double(:object, args) }

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#chart_data" do
      subject { presenter.chart_data }

      it { is_expected.to eq [1_588_291_200_000, 100] }
    end
  end

  describe ".enum" do
    let(:args) { { close: 200, datetime: DateTime.new(2020, 0o5, 0o1) } }
    let(:args_1) { { close: 100, datetime: DateTime.new(2030, 0o5, 0o1) } }
    let(:object) { double(:object, args) }
    let(:object_1) { double(:object_1, args_1) }
    let(:objects) { [object, object_1] }
    let(:symbol) { "abc" }

    subject(:presenter) { described_class::Enum.new(objects, view_context) }

    describe "#chart_data" do
      subject { presenter.chart_data }

      it "expect to return chart data" do
        expect(subject).to eq [[1_588_291_200_000, 200], [1_903_824_000_000, 100]]
      end
    end
  end
end
