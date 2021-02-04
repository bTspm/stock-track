class BusinessService
  attr_accessor :engine,
                :user

  def initialize(engine: nil, user: nil)
    @engine = engine || Allocator.new(user)
    @user = user
  end

  def company_executive_storage
    engine.company_executive_store
  end

  def company_storage
    engine.company_store
  end

  def earnings_storage
    engine.earnings_store
  end

  def exchange_storage
    engine.exchange_store
  end

  def growth_storage
    engine.growth_store
  end

  def issuer_type_storage
    engine.issuer_type_store
  end

  def news_storage
    engine.news_store
  end

  def quote_storage
    engine.quote_store
  end

  def rating_storage
    engine.ratings_store
  end

  def recommendation_trend_storage
    engine.recommendation_trend_store
  end

  def stats_storage
    engine.stats_store
  end

  def stock_storage
    engine.stock_store
  end

  def time_series_storage
    engine.time_series_store
  end

  def watch_list_storage
    engine.watch_list_store
  end
end
