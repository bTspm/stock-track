class BusinessService
  def initialize(engine = nil)
    @engine = engine
  end

  def engine
    @engine ||= Allocator.new
  end

  #Stores

  def company_storage
    engine.company_store
  end

  def earnings_storage
    engine.earnings_store
  end

  def exchange_storage
    engine.exchange_store
  end

  def issuer_type_storage
    engine.issuer_type_store
  end

  def recommendation_trend_storage
    engine.recommendation_trend_store
  end

  def stock_storage
    engine.stock_store
  end

  def time_series_storage
    engine.time_series_store
  end
end
