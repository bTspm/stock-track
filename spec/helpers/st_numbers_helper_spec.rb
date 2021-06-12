require "rails_helper"

describe StNumbersHelper do
  describe "#st_number_with_delimiter" do
    let(:number) { 123_456 }
    subject { helper.st_number_with_delimiter(number) }

    context "without number" do
      let(:number) { nil }

      it { is_expected.to eq "N/A" }
    end

    context "with number" do
      it "expect to call number to delimiter with passed arguments" do
        expect(helper).to receive(:number_with_delimiter).with(number, {}) { "Number" }

        expect(subject).to eq "Number"
      end
    end
  end

  describe "#st_number_to_currency" do
    let(:number) { 123_456 }
    let(:options) { {} }
    subject { helper.st_number_to_currency(number, options) }

    context "without number" do
      let(:number) { nil }

      it { is_expected.to eq "N/A" }
    end

    context "with number" do
      context "with default options" do
        it "expect to call number to currency with default arguments" do
          expect(helper).to receive(:number_to_currency).with(number, { precision: 2 }) { "Number" }

          expect(subject).to eq "Number"
        end
      end

      context "with option arguments" do
        let(:options) { { precision: 25 } }

        it "expect to call number to currency with arguments" do
          expect(helper).to receive(:number_to_currency).with(number, { precision: 25 }) { "Number" }

          expect(subject).to eq "Number"
        end
      end
    end
  end

  describe "#st_number_to_human" do
    let(:number) { 123_456 }
    let(:options) { {} }
    subject { helper.st_number_to_human(number, options) }

    context "without number" do
      let(:number) { nil }

      it { is_expected.to eq "N/A" }
    end

    context "with number" do
      context "with default options" do
        it "expect to call number to human with default arguments" do
          expect(helper).to receive(:number_with_delimiter).with(number) { "Delim Number" }
          expect(helper).to receive(:number_to_human).with(number, { precision: 2 }) { "Number" }
          expect(helper).to receive(:tooltip_wrapper).with("Delim Number").and_yield

          expect(subject).to eq "Number"
        end
      end

      context "with option arguments" do
        let(:options) { { precision: 25 } }

        it "expect to call number to human with arguments" do
          expect(helper).to receive(:number_with_delimiter).with(number) { "Delim Number" }
          expect(helper).to receive(:number_to_human).with(number, { precision: 25 }) { "Number" }
          expect(helper).to receive(:tooltip_wrapper).with("Delim Number").and_yield

          expect(subject).to eq "Number"

          expect(subject).to eq "Number"
        end
      end
    end
  end

  describe "#st_number_to_percentage" do
    let(:percentage) { 123_456.8912 }
    subject { helper.st_number_to_percentage(percentage) }

    context "without percentage" do
      let(:percentage) { nil }

      it { is_expected.to eq "N/A" }
    end

    context "with percentage" do
      it "expect to call number to percentage with opetionss" do
        expect(helper).to receive(:number_to_percentage).with(
          123_456.89,
          { precision: 2, delimiter: ",", separator: "." }
        ) { "Number" }

        expect(subject).to eq "Number"
      end
    end
  end
end
