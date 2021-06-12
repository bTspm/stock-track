require "rails_helper"

describe StocksHelper do
  describe "#content_color_by_value" do
    let(:content) { double(:content) }
    let(:value) { 100 }

    subject { helper.content_color_by_value(content: content, value: value) }

    context "with content" do
      context "value - negative" do
        let(:value) { -100 }

        it "expect to call negative_content" do
          expect(helper).to receive(:negative_content).with(content) { "Negative value" }

          expect(subject).to eq "Negative value"
        end
      end

      context "value - positive" do
        it "expect to call positive_content" do
          expect(helper).to receive(:positive_content).with(content) { "Positive value" }

          expect(subject).to eq "Positive value"
        end
      end

      context "value - 0" do
        let(:value) { 0 }

        it "expect to call neither negative_content nor positive_content" do
          expect(helper).not_to receive(:negative_content)
          expect(helper).not_to receive(:positive_content)

          expect(subject).to eq content
        end
      end
    end

    context "without context" do
      let(:content) { nil }

      context "value - negative" do
        let(:value) { -100 }

        it "expect to call negative_content" do
          expect(helper).to receive(:negative_content).with(value) { "Negative value" }

          expect(subject).to eq "Negative value"
        end
      end

      context "value - positive" do
        it "expect to call positive_content" do
          expect(helper).to receive(:positive_content).with(value) { "Positive value" }

          expect(subject).to eq "Positive value"
        end
      end

      context "value - 0" do
        let(:value) { 0 }

        it "expect to call neither negative_content nor positive_content" do
          expect(helper).not_to receive(:negative_content)
          expect(helper).not_to receive(:positive_content)

          expect(subject).to eq value
        end
      end
    end
  end

  describe "#negative_content" do
    let(:content) { double(:content) }

    subject { helper.negative_content(content) }

    it { is_expected.to have_css("span", class: "text-danger") }
  end

  describe "#positive_content" do
    let(:content) { double(:content) }

    subject { helper.positive_content(content) }

    it { is_expected.to have_css("span", class: "text-success") }
  end

  describe "#price_icon" do
    let(:icon) { "fas fa-arrow-alt-circle-up" }
    let(:value) { 100 }

    subject { helper.price_icon(value) }

    before :each do
      expect(helper).to receive(:fontawesome_icon).with(name_icon_with_style: icon) { "FontawesomeIcon" }
      expect(helper).to receive(:content_color_by_value).with(content: "FontawesomeIcon", value: value) { "Price Icon" }
    end

    context "negative" do
      let(:icon) { "fas fa-arrow-alt-circle-down" }
      let(:value) { -100 }

      it { is_expected.to eq "Price Icon" }
    end

    context "positive" do
      it { is_expected.to eq "Price Icon" }
    end

    context "0" do
      let(:value) { 0 }

      it { is_expected.to eq "Price Icon" }
    end
  end

  describe "#stock_information_link_with_company_name" do
    let(:company) { build(:entity_company) }
    subject { helper.stock_information_link_with_company_name(company) }

    it "expect to return stock information link" do
      expect(subject).to have_css(".font-weight-bold")
      expect(subject).to include company.symbol
      expect(subject).to include company.security_name
    end
  end
end
