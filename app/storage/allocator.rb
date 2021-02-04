class Allocator
  include RemoteClients

  attr_accessor :user

  def initialize(user=nil)
    @user = user
  end

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

  def ratings_store
    RatingsStore.new
  end

  def recommendation_trend_store
    RecommendationTrendStore.new
  end

  def stats_store
    StatsStore.new
  end

  def stock_store
    StockStore.new
  end

  def time_series_store
    TimeSeriesStore.new
  end

  def watch_list_store
    WatchListStore.new(user)
  end
end
