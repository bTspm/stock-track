require "rails_helper"

describe StocksHelper do
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
      expect(helper).to receive(:tooltip_wrapper).with(company.security_name).and_yield

      expect(subject).to have_css(".font-weight-bold")
      expect(subject).to include company.symbol
      expect(subject).to include company.security_name
    end
  end

  describe "#stock_information_link_for_compare" do
    let(:symbol) { "AAPL" }
    subject { helper.stock_information_link_for_compare(symbol) }

    it "expect to return stock information link" do
      expect(subject).to include "AAPL"
      expect(subject).to have_css("a", class: "text-white")
    end
  end

  describe "#section_row" do
    let(:label) { "Label" }
    let(:symbols) { ["AAPL"] }
    subject { helper.section_row(label: label, symbols: symbols) }

    it "expect to return a table row with label and symbol table data" do
      expect(helper).to receive(:stock_information_link_for_compare).with("AAPL") { "Stock Link" }

      expect(subject).to include "Label"
      expect(subject).to include "bg-secondary text-uppercase text-white font-weight-bold"
      expect(subject).to include "Stock Link"
    end
  end

  describe "#data_row" do
    let(:label) { "Label" }
    let(:values) { [100] }
    let(:winner_index) { 0 }
    subject { helper.data_row(label: label, values: values, winner_index: winner_index) }

    context "without winner index" do
      let(:winner_index) { nil }

      it "expect to return a table row with label and symbol table data" do
        expect(subject).to include "Label"
        expect(subject).to include "100"
        expect(subject).not_to include "row-winner"
      end
    end

    context "with winner index " do
      it "expect to return a table row with label and symbol table data" do
        expect(subject).to include "Label"
        expect(subject).to include "100"
        expect(subject).to include "row-winner"
      end
    end
  end
end
