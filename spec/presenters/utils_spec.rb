require "rails_helper"

describe Utils do
  class DummyClass
    include Utils
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

  describe "#readable_date" do
    let(:date) { Date.new(2020, 05, 01) }

    subject { dummy_class.readable_date(date: date) }

    context "without date" do
      let(:date) { nil }

      it { is_expected.to eq "N/A" }
    end

    context "with date" do
      context "with format" do
        it { is_expected.to eq "May 01, 2020" }
      end

      context "with default format" do
        let(:format) { "%b %d" }

        subject { dummy_class.readable_date(date: date, format: format) }

        it { is_expected.to eq "May 01" }
      end
    end
  end

  describe "#readable_datetime" do
    let(:datetime) { DateTime.new(2020, 05, 01) }

    subject { dummy_class.readable_datetime(datetime: datetime) }

    context "without datetime" do
      let(:datetime) { nil }

      it { is_expected.to eq "N/A" }
    end

    context "with datetime" do
      context "with format" do
        it { is_expected.to eq "Apr 30, 2020 8:00:00 PM" }
      end

      context "with default format" do
        let(:format) { "%b %d" }

        subject { dummy_class.readable_datetime(datetime: datetime, format: format) }

        it { is_expected.to eq "Apr 30" }
      end
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
