require "rails_helper"

describe CompareMeta::DataRow do
  let(:display_source) { "display_source" }
  let(:compare_source) { "company.data_object_source" }
  let(:label) { "Label" }
  subject(:data_row) do
    described_class.new(
      compare_source: compare_source,
      display_source: display_source,
      order_for_compare: :asc,
      label: label
    )
  end

  describe "#initialize" do
    it { expect(data_row.order_for_compare).to eq :asc }
    it { expect(data_row.compare_source).to eq compare_source }


    context "display_source" do
      subject { data_row.display_source }

      context "with display_source" do
        it "expect to return display source" do
          expect(subject).to eq "display_source"
        end
      end

      context "without display_source" do
        let(:display_source) { "" }

        it "expect to return display source modified from compare source" do
          expect(subject).to eq "company.source"
        end
      end
    end

    context "label" do
      subject { data_row.label }

      context "with label" do
        it "expect to return label" do
          expect(subject).to eq "Label"
        end
      end

      context "without label" do
        let(:label) { "" }

        it "expect to call locale" do
          expect(I18n).to receive(:t).with("compare.display_source") { "Label from Locale" }

          expect(subject).to eq "Label from Locale"
        end
      end
    end

    context "is_compare" do
      subject { data_row.is_compare }

      context "with compare_source" do
        it { is_expected.to eq true }
      end

      context "without compare_source" do
        let(:compare_source) { nil }

        it { is_expected.to eq false }
      end
    end
  end
end
