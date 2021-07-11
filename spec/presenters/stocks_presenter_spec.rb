require "rails_helper"

describe StocksPresenter do
  describe ".scalar" do
    let(:stock) { build(:entity_stock) }
    subject(:presenter) { described_class::Scalar.new(stock, view_context) }

    context "delegate" do
      context "company" do
        it { should delegate_method(:sector).to(:company) }
        it { should delegate_method(:security_name).to(:company) }
        it { should delegate_method(:symbol).to(:company) }
        it { should delegate_method(:name).to(:company) }
        it { should delegate_method(:exchange_name).to(:company) }
      end

      context "growth" do
        it { should delegate_method(:ytd).to(:growth) }
      end

      context "quote" do
        it { should delegate_method(:price).to(:quote) }
        it { should delegate_method(:change).to(:quote) }
        it { should delegate_method(:change_percent).to(:quote) }
        it { should delegate_method(:updated_at).to(:quote) }
        it { should delegate_method(:open).to(:quote) }
        it { should delegate_method(:high).to(:quote) }
        it { should delegate_method(:low).to(:quote) }
        it { should delegate_method(:volume).to(:quote) }
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
        expect(CompaniesPresenter).to receive(:present).with(stock.company, view_context) { "Company" }

        expect(subject).to eq "Company"
      end
    end

    describe "#earnings" do
      subject { presenter.earnings }

      it "expect to return earnings presenter" do
        expect(EarningsPresenter).to receive(:present).with(stock.earnings, view_context) { "earnings" }

        expect(subject).to eq "earnings"
      end
    end

    describe "#external_analysis" do
      subject { presenter.external_analysis }

      it "expect to return external_analysis presenter" do
        expect(
          ExternalAnalysisPresenter
        ).to receive(:present).with(stock.external_analysis, view_context) { "External Analysis" }

        expect(subject).to eq "External Analysis"
      end
    end

    describe "#latest_earnings" do
      subject { presenter.latest_earnings }

      context "when there is no latest_earnings" do
        let(:stock) { build :entity_stock, earnings: [] }

        it { is_expected.to be_nil }
      end

      context "when there is latest_earnings" do
        it "expect to return earnings presenter" do
          expect(stock).to receive(:latest_earnings).exactly(2).times { "latest earnings" }
          expect(EarningsPresenter).to receive(:present).with("latest earnings", view_context) { "Latest Earnings" }

          expect(subject).to eq "Latest Earnings"
        end
      end
    end

    describe "#growth" do
      subject { presenter.growth }

      it "expect to return growth presenter" do
        expect(GrowthPresenter).to receive(:present).with(stock.growth, view_context) { "Growth" }

        expect(subject).to eq "Growth"
      end
    end

    describe "#news" do
      subject { presenter.news }

      it "expect to return news presenter" do
        expect(NewsPresenter).to receive(:present).with(stock.news, view_context) { "news" }

        expect(subject).to eq "news"
      end
    end

    describe "#quote" do
      subject { presenter.quote }

      it "expect to return quote presenter" do
        expect(QuotesPresenter).to receive(:present).with(stock.quote, view_context) { "Quote" }

        expect(subject).to eq "Quote"
      end
    end

    describe "#stats" do
      subject { presenter.stats }

      it "expect to return stats presenter" do
        expect(StatsPresenter).to receive(:present).with(stock.stats, view_context) { "Stats" }

        expect(subject).to eq "Stats"
      end
    end

    describe "#time_series" do
      subject { presenter.time_series }

      it "expect to return time_series presenter" do
        expect(TimeSeriesPresenter).to receive(:present).with(stock.time_series, view_context) { "time_series" }

        expect(subject).to eq "time_series"
      end
    end

    describe "#time_series_chart_data_for_compare" do
      let(:time_series_presenter) { double :time_series_presenter }
      subject { presenter.time_series_chart_data_for_compare }

      it "expect to return chart_data_for_compare delegated from time_series" do
        expect(TimeSeriesPresenter).to receive(:present).with(stock.time_series, view_context) { time_series_presenter }
        expect(time_series_presenter).to receive(:chart_data) { "Time Series Chart Data" }

        expect(subject).to include(data: "Time Series Chart Data")
        expect(subject).to include(name: "AAPL")
      end
    end
  end

  describe ".enum" do
    let(:stock_aapl) { build(:entity_stock, company: build(:entity_company, symbol: "AAPL")) }
    let(:stock_fb) { build(:entity_stock, company: build(:entity_company, symbol: "FB")) }
    let(:stocks) { [stock_aapl, stock_fb] }
    subject(:presenter) { described_class::Enum.new(stocks, view_context) }

    describe "#companies" do
      subject { presenter.companies }

      it "expect to return array of company presenters" do
        expect(CompaniesPresenter).to receive(:present).with(stock_aapl.company, view_context) { "Company AAPL" }
        expect(CompaniesPresenter).to receive(:present).with(stock_fb.company, view_context) { "Company FB" }

        expect(subject).to match_array ["Company AAPL", "Company FB"]
      end
    end

    describe "#symbols" do
      subject { presenter.symbols }

      it { is_expected.to match_array ["AAPL", "FB"] }
    end

    describe "#time_series_chart_data_for_compare" do
      let(:stocks) { [stock_aapl] }
      subject { presenter.time_series_chart_data_for_compare }

      it "expect to return array of time series charts" do
        expect_any_instance_of(
          StocksPresenter::Scalar
        ).to receive(:time_series_chart_data_for_compare) { "TIme Series AAPL" }

        expect(subject).to match_array ["TIme Series AAPL"]
      end
    end

    describe "#table_data" do
      let(:sections) { { company: [data_row] } }
      let(:aapl_employees) { 100 }
      let(:company_aapl) { build(:entity_company, symbol: "AAPL", employees: aapl_employees) }
      let(:stock_aapl) { build(:entity_stock, company: company_aapl) }
      let(:fb_employees) { 200 }
      let(:company_fb) { build(:entity_company, symbol: "FB", employees: fb_employees) }
      let(:stock_fb) { build(:entity_stock, company: company_fb) }
      let(:nflx_employees) { 300 }
      let(:company_nflx) { build(:entity_company, symbol: "NFLX", employees: nflx_employees) }
      let(:stock_nflx) { build(:entity_stock, company: company_nflx) }
      let(:stocks) { [stock_aapl, stock_fb, stock_nflx] }
      subject { presenter.table_data }

      before do
        stub_const("CompareMeta::ORDERED_COMPARE_SECTIONS", sections)
        expect(
          view_context
        ).to receive(:section_row).with(label: :company, symbols: ["AAPL", "FB", "NFLX"]) { "Section" }
      end

      context "data_row for compare" do
        let(:data_row) do
          double :data_row,
                 label: "Row Label",
                 is_compare: true,
                 order_for_compare: order_for_compare,
                 compare_source: "company.data_object_employees",
                 display_source: "company.employees"
        end

        context "when compare order is asc" do
          let(:order_for_compare) { :asc }

          context "when one of the value is null" do
            let(:nflx_employees) { nil }

            it "expect to call data_row with label, values and lowest value as winner index" do
              expect(view_context).to receive(:data_row).with(
                label: "Row Label",
                values: ["~100", "~200", "N/A"],
                winner_index: 0
              ) { "Data" }

              expect(subject).to match_array ["Section", "Data"]
            end
          end

          context "when all values are same" do
            let(:aapl_employees) { 100 }
            let(:fb_employees) { 100 }
            let(:nflx_employees) { 100 }

            it "expect to call data_row with label, values and winner index with null value" do
              expect(view_context).to receive(:data_row).with(
                label: "Row Label",
                values: ["~100", "~100", "~100"],
                winner_index: nil
              ) { "Data" }

              expect(subject).to match_array ["Section", "Data"]
            end
          end

          context "when identified winner" do
            it "expect to call data_row with label, values and lowest value as winner index" do
              expect(view_context).to receive(:data_row).with(
                label: "Row Label",
                values: ["~100", "~200", "~300"],
                winner_index: 0
              ) { "Data" }

              expect(subject).to match_array ["Section", "Data"]
            end
          end
        end

        context "when compare order is desc" do
          let(:order_for_compare) { :desc }

          context "when one of the value is null" do
            let(:nflx_employees) { nil }

            it "expect to call data_row with label, values and highest value as winner index" do
              expect(view_context).to receive(:data_row).with(
                label: "Row Label",
                values: ["~100", "~200", "N/A"],
                winner_index: 1
              ) { "Data" }

              expect(subject).to match_array ["Section", "Data"]
            end
          end

          context "when all values are same" do
            let(:aapl_employees) { 100 }
            let(:fb_employees) { 100 }
            let(:nflx_employees) { 100 }

            it "expect to call data_row with label, values and winner index with null value" do
              expect(view_context).to receive(:data_row).with(
                label: "Row Label",
                values: ["~100", "~100", "~100"],
                winner_index: nil
              ) { "Data" }

              expect(subject).to match_array ["Section", "Data"]
            end
          end

          context "when identified winner" do
            it "expect to call data_row with label, values and highest value as winner index" do
              expect(view_context).to receive(:data_row).with(
                label: "Row Label",
                values: ["~100", "~200", "~300"],
                winner_index: 2
              ) { "Data" }

              expect(subject).to match_array ["Section", "Data"]
            end
          end
        end
      end

      context "data_row not for compare" do
        let(:data_row) { double :section, display_source: "company.employees", is_compare: false, label: "Row Label" }

        it "expect to call data_row with label, values and winner index with null value" do
          expect(view_context).to receive(:data_row).with(
            label: "Row Label",
            values: ["~100", "~200", "~300"],
            winner_index: nil
          ) { "Data" }

          expect(subject).to match_array ["Section", "Data"]
        end
      end
    end
  end
end
