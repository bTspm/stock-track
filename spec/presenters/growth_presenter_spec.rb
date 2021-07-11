require "rails_helper"

describe GrowthPresenter do
  describe ".scalar" do
    let(:growth) { build(:entity_growth) }
    subject(:presenter) { described_class::Scalar.new(growth, view_context) }

    describe "#chart_data" do
      subject { presenter.chart_data }

      context "with values" do
        it "expect to return chart data" do
          result = subject
          expect(result[:data]).to eq [5_000, 1_000, 10_000, 600, 300, 100, 5]
          expect(result[:xaxis_titles]).to eq %w[5Y 1Y YTD 6M 3M 1M 5D]
        end
      end

      context "when a value is nil" do
        let(:growth) { build(:entity_growth, ytd: nil) }

        it "expect to return chart data with nil" do
          result = subject
          expect(result[:data]).to eq [5_000, 1_000, nil, 600, 300, 100, 5]
          expect(result[:xaxis_titles]).to eq %w[5Y 1Y YTD 6M 3M 1M 5D]
        end
      end
    end

    describe "#day_5" do
      subject { presenter.day_5 }

      context "without day_5" do
        let(:growth) { build(:entity_growth, day_5: nil) }

        it { is_expected.to eq "N/A" }
      end

      context "with day_5" do
        it "expect to format percentage and format the color" do
          expect(view_context).to receive(:st_number_to_percentage).with(5) { "Pct" }
          expect(view_context).to receive(:content_color_by_value).with(content: "Pct", value: 5) { "Color Value" }
          
          expect(subject).to eq "Color Value"
        end
      end
    end

    describe "#month_1" do
      subject { presenter.month_1 }

      context "without month_1" do
        let(:growth) { build(:entity_growth, month_1: nil) }

        it { is_expected.to eq "N/A" }
      end

      context "with month_1" do
        it "expect to format percentage and format the color" do
          expect(view_context).to receive(:st_number_to_percentage).with(100) { "Pct" }
          expect(view_context).to receive(:content_color_by_value).with(content: "Pct", value: 100) { "Color Value" }

          expect(subject).to eq "Color Value"
        end
      end
    end

    describe "#month_3" do
      subject { presenter.month_3 }

      context "without month_3" do
        let(:growth) { build(:entity_growth, month_3: nil) }

        it { is_expected.to eq "N/A" }
      end

      context "with month_3" do
        it "expect to format percentage and format the color" do
          expect(view_context).to receive(:st_number_to_percentage).with(300) { "Pct" }
          expect(view_context).to receive(:content_color_by_value).with(content: "Pct", value: 300) { "Color Value" }

          expect(subject).to eq "Color Value"
        end
      end
    end

    describe "#month_6" do
      subject { presenter.month_6 }

      context "without month_6" do
        let(:growth) { build(:entity_growth, month_6: nil) }

        it { is_expected.to eq "N/A" }
      end

      context "with month_6" do
        it "expect to format percentage and format the color" do
          expect(view_context).to receive(:st_number_to_percentage).with(600) { "Pct" }
          expect(view_context).to receive(:content_color_by_value).with(content: "Pct", value: 600) { "Color Value" }

          expect(subject).to eq "Color Value"
        end
      end
    end

    describe "#ytd" do
      subject { presenter.ytd }

      context "without ytd" do
        let(:growth) { build(:entity_growth, ytd: nil) }

        it { is_expected.to eq "N/A" }
      end

      context "with ytd" do
        it "expect to format percentage and format the color" do
          expect(view_context).to receive(:st_number_to_percentage).with(10_000) { "Pct" }
          expect(view_context).to receive(:content_color_by_value).with(content: "Pct", value: 10_000) { "Color Value" }

          expect(subject).to eq "Color Value"
        end
      end
    end

    describe "#year_1" do
      subject { presenter.year_1 }

      context "without year_1" do
        let(:growth) { build(:entity_growth, year_1: nil) }

        it { is_expected.to eq "N/A" }
      end

      context "with year_1" do
        it "expect to format percentage and format the color" do
          expect(view_context).to receive(:st_number_to_percentage).with(1_000) { "Pct" }
          expect(view_context).to receive(:content_color_by_value).with(content: "Pct", value: 1_000) { "Color Value" }

          expect(subject).to eq "Color Value"
        end
      end
    end

    describe "#year_5" do
      subject { presenter.year_5 }

      context "without year_5" do
        let(:growth) { build(:entity_growth, year_5: nil) }

        it { is_expected.to eq "N/A" }
      end

      context "with year_5" do
        it "expect to format percentage and format the color" do
          expect(view_context).to receive(:st_number_to_percentage).with(5_000) { "Pct" }
          expect(view_context).to receive(:content_color_by_value).with(content: "Pct", value: 5_000) { "Color Value" }

          expect(subject).to eq "Color Value"
        end
      end
    end

    describe "#max" do
      subject { presenter.max }

      context "without max" do
        let(:growth) { build(:entity_growth, max: nil) }

        it { is_expected.to eq "N/A" }
      end

      context "with max" do
        it "expect to format percentage and format the color" do
          expect(view_context).to receive(:st_number_to_percentage).with(100_000) { "Pct" }
          expect(
            view_context
          ).to receive(:content_color_by_value).with(content: "Pct", value: 100_000) { "Color Value" }

          expect(subject).to eq "Color Value"
        end
      end
    end
  end
end
