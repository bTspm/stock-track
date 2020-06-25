class Allocator
  def company_executive_store
    CompanyExecutiveStore.new
  end

  def company_store
    CompanyStore.new
  end

  def earnings_store
    EarningsStore.new
  end

  def exchange_store
    ExchangeStore.new
  end

  def growth_store
    GrowthStore.new
  end

  def issuer_type_store
    IssuerTypeStore.new
  end

  def news_store
    NewsStore.new
  end

  def quote_store
    QuoteStore.new
  end

  def recommendation_trend_store
    RecommendationTrendStore.new
  end

  def stats_store
    StatsStore.new
  end

  def time_series_store
    TimeSeriesStore.new
  end
end
