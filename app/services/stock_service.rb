class StockService < BusinessService
  include Services

  def create_or_update_exchanges
    exchange_storage.create_or_update_exchanges
  end

  def company_by_symbol(symbol)
    company_storage.by_symbol(symbol)
  end

  def news_by_symbol(symbol)
    stock_storage.news_by_symbol(symbol: symbol)
  end

  def stock_by_symbol(symbol)
    company = company_by_symbol(symbol)

    if company.null_object?
      company = company_storage.by_symbol_from_iex(symbol)
      # company.executives = company_storage.company_executives_by_symbol(symbol)
      company = company_storage.save_company(company)
    end

    s = stock_storage.stock_by_symbol(symbol)
    s.company = company
    s
  end

  def time_series(symbol)
    request = TimeSeriesRequest.five_year(symbol)
    time_series_storage.time_series_from_twelve_data(request.to_options)
  end

  def recommendation_trends(symbol)
    recommendation_trend_storage.recommendation_trends_from_finn_hub(symbol)
  end

  def earnings_by_symbol(symbol)
    {
      eps_estimates: earnings_storage.eps_estimates_from_finn_hub(symbol),
      eps: earnings_storage.eps_from_finn_hub(symbol)
    }
  end
end
