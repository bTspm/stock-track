module CompareMeta
  class DataRow
    attr_accessor :display_source, :is_compare, :order_for_compare, :compare_source, :label

    def initialize(compare_source: nil, display_source: nil, order_for_compare: nil, label: "")
      @compare_source = compare_source
      @display_source = display_source.presence || compare_source&.gsub("data_object_", "")
      @is_compare = compare_source ? true : false
      @order_for_compare = order_for_compare
      @label = label.presence ||  I18n.t("compare.#{@display_source}")
    end
  end

  ANALYSIS = [
    DataRow.new(compare_source: "external_analysis.data_object_average_rating_rank", order_for_compare: :asc),
    DataRow.new(
      display_source: "external_analysis.average_rating_signal",
      compare_source: "external_analysis.data_object_average_rating_rank",
      order_for_compare: :asc),
    DataRow.new(compare_source: "external_analysis.data_object_total_analysts", order_for_compare: :desc),
  ]

  COMPANY = [
    DataRow.new(display_source: "company.security_name"),
    DataRow.new(display_source: "company.exchange_name"),
    DataRow.new(display_source: "company.issuer_type_name_with_code"),
    DataRow.new(display_source: "company.sector"),
    DataRow.new(display_source: "company.industry"),
    DataRow.new(display_source: "company.sic_code"),
    DataRow.new(compare_source: "company.data_object_employees", order_for_compare: :desc)
  ]

  EARNINGS = [
    DataRow.new(display_source: "stats.ttm_eps"),
    DataRow.new(display_source: "latest_earnings.reported_quarter"),
    DataRow.new(display_source: "latest_earnings.actual"),
    DataRow.new(display_source: "latest_earnings.estimate"),
    DataRow.new(display_source: "latest_earnings.surprise"),
    DataRow.new(compare_source: "latest_earnings.data_object_surprise_percent", order_for_compare: :desc)
  ]

  GROWTH = [
    DataRow.new(compare_source: "growth.data_object_day_5", order_for_compare: :desc),
    DataRow.new(compare_source: "growth.data_object_month_1", order_for_compare: :desc),
    DataRow.new(compare_source: "growth.data_object_month_3", order_for_compare: :desc),
    DataRow.new(compare_source: "growth.data_object_month_6", order_for_compare: :desc),
    DataRow.new(compare_source: "growth.data_object_ytd", order_for_compare: :desc),
    DataRow.new(compare_source: "growth.data_object_year_1", order_for_compare: :desc),
    DataRow.new(compare_source: "growth.data_object_year_5", order_for_compare: :desc),
    DataRow.new(compare_source: "growth.data_object_max", order_for_compare: :desc),
  ]

  QUOTE = [
    DataRow.new(display_source: "quote.price"),
    DataRow.new(display_source: "quote.change"),
    DataRow.new(compare_source: "quote.data_object_change_percent", order_for_compare: :desc),
    DataRow.new(display_source: "quote.volume"),
    DataRow.new(display_source: "stats.volume_30_day_average"),
    DataRow.new(display_source: "quote.open"),
    DataRow.new(display_source: "quote.high"),
    DataRow.new(display_source: "quote.low"),
    DataRow.new(display_source: "quote.previous_close")
  ]

  STATS = [
    DataRow.new(compare_source: "stats.data_object_market_cap", order_for_compare: :desc),
    DataRow.new(compare_source: "stats.data_object_dividend_yield", order_for_compare: :desc),
    DataRow.new(compare_source: "stats.data_object_ttm_dividend_rate", order_for_compare: :desc),
    DataRow.new(display_source: "stats.shares_outstanding"),
    DataRow.new(compare_source: "stats.data_object_pe_ratio", order_for_compare: :asc),
    DataRow.new(compare_source: "stats.data_object_beta", order_for_compare: :asc),
    DataRow.new(compare_source: "stats.data_object_float", order_for_compare: :asc),
    DataRow.new(display_source: "stats.week_52_high"),
    DataRow.new(display_source: "stats.week_52_low"),
  ]

  ORDERED_COMPARE_SECTIONS = {
    quote: QUOTE,
    stats: STATS,
    earnings: EARNINGS,
    growth: GROWTH,
    analysis: ANALYSIS,
    company: COMPANY
  }
end
