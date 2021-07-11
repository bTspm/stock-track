class StocksPresenter
  include Btspm::Presenters::Presentable

  class Scalar < Btspm::Presenters::ScalarPresenter
    include Utils

    delegate :sector, :security_name, :symbol, :name, :exchange_name, :issuer_type_name_with_code, :industry, :sic_code, to: :company
    delegate :ytd, to: :growth
    delegate :price,
             :change,
             :change_percent,
             :updated_at,
             :open,
             :high,
             :low,
             :volume,
             :previous_close,
             to: :quote
    delegate :dividend_yield, :market_cap, to: :stats
    delegate :chart_data, to: :time_series, prefix: true
    delegate :average_rating_rank, :average_rating_signal, :total_analysts, to: :external_analysis

    def company
      @company ||= ::CompaniesPresenter.present(data_object_company, h)
    end

    def earnings
      @earnings ||= ::EarningsPresenter.present(data_object_earnings, h)
    end

    def external_analysis
      @external_analysis ||= ExternalAnalysisPresenter.present(data_object_external_analysis, h)
    end

    def latest_earnings
      return nil if data_object_latest_earnings.blank?

      @latest_earnings ||= ::EarningsPresenter.present(data_object_latest_earnings, h)
    end

    def growth
      @growth ||= ::GrowthPresenter.present(data_object_growth, h)
    end

    def news
      @news ||= ::NewsPresenter.present(data_object_news, h)
    end

    def quote
      @quote ||= ::QuotesPresenter.present(data_object_quote, h)
    end

    def stats
      @stats ||= ::StatsPresenter.present(data_object_stats, h)
    end

    def time_series
      @time_series ||= ::TimeSeriesPresenter.present(data_object_time_series, h)
    end

    def time_series_chart_data_for_compare
      { data: time_series_chart_data, name: symbol }
    end
  end

  class Enum < Btspm::Presenters::EnumPresenter
    include Utils

    def companies
      @companies ||= map(&:company)
    end

    def symbols
      @symbols ||= map(&:symbol)
    end

    def table_data
      rows = []

      CompareMeta::ORDERED_COMPARE_SECTIONS.each do |section_title, data_rows|
        rows << h.section_row(label: section_title, symbols: symbols)

        data_rows.each do |data_row|
          winner_index = _winner_index(data_row) if data_row.is_compare
          rows << h.data_row(
            label: data_row.label,
            values: map { |stock| stock.instance_eval(data_row.display_source) },
            winner_index: winner_index
          )
        end
      end

      rows
    end

    def time_series_chart_data_for_compare
      map(&:time_series_chart_data_for_compare)
    end

    private

    def _winner_index(data_row)
      original_values = map do |stock|
        value = stock.instance_eval(data_row.compare_source)
        if value
          value
        else
          # If value is null use a high or low value to place the column at last for sort.
          data_row.order_for_compare == :asc ? StConstants::MAX_HIGH_VALUE : StConstants::MAX_LOW_VALUE
        end
      end
      return nil if original_values.compact.uniq.size == 1

      if data_row.order_for_compare == :asc
        original_values.each_with_index.min&.last
      else
        original_values.each_with_index.max&.last
      end
    end
  end
end
