class Allocator
  def company_store
    CompanyStore.new
  end

  def company_executive_store
    CompanyExecutiveStore.new
  end

  def earnings_store
    EarningsStore.new
  end

  def exchange_store
    ExchangeStore.new
  end

  def issuer_type_store
    IssuerTypeStore.new
  end

  def recommendation_trend_store
    RecommendationTrendStore.new
  end

  def stock_store
    StockStore.new
  end

  def time_series_store
    TimeSeriesStore.new
  end
end
