require "rails_helper"

describe StocksPresenter do
  describe ".scalar" do
    let(:object) { build(:entity_stock) }
    subject(:presenter) { described_class::Scalar.new(object, view_context) }

    context "delegate" do
      context "company" do
        it { should delegate_method(:sector).to(:company) }
        it { should delegate_method(:security_name).to(:company) }
        it { should delegate_method(:symbol).to(:company) }
      end

      context "growth" do
        it { should delegate_method(:formatted_ytd).to(:growth) }
      end

      context "quote" do
        it { should delegate_method(:latest_price_info_amount).to(:quote) }
        it { should delegate_method(:latest_price_info_change).to(:quote) }
        it { should delegate_method(:latest_price_info_last_updated).to(:quote) }
        it { should delegate_method(:open).to(:quote) }
        it { should delegate_method(:high).to(:quote) }
        it { should delegate_method(:low).to(:quote) }
        it { should delegate_method(:volume).to(:quote) }
        it { should delegate_method(:previous_volume).to(:quote) }
        it { should delegate_method(:previous_close).to(:quote) }
      end

      context "growth" do
        it { should delegate_method(:dividend_yield).to(:stats) }
        it { should delegate_method(:market_cap).to(:stats) }
      end
    end

    describe "#company" do
      subject { presenter.company }

      it "expect to return company presenter" do
        expect(CompaniesPresenter).to receive(:present).with(object.company, view_context) { "Company" }

        expect(subject).to eq "Company"
      end
    end

    describe "#growth" do
      subject { presenter.growth }

      it "expect to return growth presenter" do
        expect(GrowthPresenter).to receive(:present).with(object.growth, view_context) { "Growth" }

        expect(subject).to eq "Growth"
      end
    end

    describe "#latest_price_info_change_percent" do
      subject { presenter.latest_price_info_change_percent }

      it { is_expected.to include "1,000%" }
    end

    describe "#quote" do
      subject { presenter.quote }

      it "expect to return quote presenter" do
        expect(QuotesPresenter).to receive(:present).with(object.quote, view_context) { "Quote" }

        expect(subject).to eq "Quote"
      end
    end

    describe "#stats" do
      subject { presenter.stats }

      it "expect to return stats presenter" do
        expect(StatsPresenter).to receive(:present).with(object.stats, view_context) { "Stats" }

        expect(subject).to eq "Stats"
      end
    end
  end
end
