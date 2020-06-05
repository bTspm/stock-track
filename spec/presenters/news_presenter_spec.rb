require "rails_helper"

describe NewsPresenter do
  describe ".scalar" do
    let(:datetime) { double(:datetime) }
    let(:object) { double(:object, datetime: datetime, source: source) }
    let(:source) { double(:source) }

    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    describe "#meta_info" do
      subject { presenter.meta_info }
      it "expect to return chart data" do
        expect(view_context).to receive(:fontawesome_icon).with("fas fa-user text-info", source) { "Formatted Source" }
        expect(presenter).to receive(:readable_datetime).with(datetime: datetime) { "DateTime" }
        expect(
         view_context
        ).to receive(:fontawesome_icon).with("fas fa-clock text-warning", "DateTime") { "Formatted DateTime" }

        expect(subject).to eq "Formatted Source | Formatted DateTime"
      end
    end
  end

  describe ".enum" do
    let(:object) { double(:object) }
    let(:objects) { [object, object] }

    subject(:presenter) { described_class::Enum.new(objects, view_context) }

    describe "#grouped" do
      subject { presenter.grouped }
      it "expect to return grouped news" do
        expect(described_class).to receive(:present).exactly(2) { "News Group" }

        expect(subject).to match_array ["News Group", "News Group"]
      end
    end
  end
end
