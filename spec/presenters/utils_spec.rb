require "rails_helper"

describe Utils do
  class DummyClass
    include Utils

    alias_method :h, :view_context
  end

  subject(:dummy_class) { DummyClass.new }

  describe "#format_percentage" do
    let(:percentage) { 0.823456 }

    subject { dummy_class.format_percentage(percentage) }

    context "without percentage" do
      let(:percentage) { nil }

      it { is_expected.to eq "N/A" }
    end

    context "with percentage" do
      it { is_expected.to eq "82.35%" }
    end
  end

  describe "#percentage_value" do
    let(:percentage) { 0.823456 }

    subject { dummy_class.percentage_value(percentage) }

    context "without percentage" do
      let(:percentage) { nil }

      it { is_expected.to be_nil }
    end

    context "with percentage" do
      it { is_expected.to eq 82.35 }
    end
  end

  describe "#value_or_na" do
    let(:value) { double(:vslue) }

    subject { dummy_class.value_or_na(value) }

    context "without value" do
      let(:value) { nil }

      it { is_expected.to eq "N/A" }
    end

    context "with value" do
      it { is_expected.to eq value }
    end
  end
end
