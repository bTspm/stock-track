class StocksController < ApplicationController
  def earnings
    earnings = present(stock_service.earnings_by_symbol(params[:symbol]), EarningsPresenter)
    render partial: "stocks/information_v2/earnings", locals: { earnings: earnings }
  end

  def growth
    growth = present(stock_service.growth_by_symbol(params[:symbol]), GrowthPresenter)
    render partial: "stocks/information_v2/growth", locals: { growth: growth }
  end

  def home; end

  def information
    @company = present(company_service.company_by_symbol(params[:symbol]), CompaniesPresenter)
  end

  def news
    news = present(stock_service.news_by_symbol(params[:symbol]), NewsPresenter)
    render partial: "stocks/information_v2/news", locals: { news: news }
  end

  def quote
    quote = present(stock_service.quote_by_symbol(params[:symbol]), QuotesPresenter)
    render partial: "stocks/information_v2/quote_information", locals: { quote: quote }
  end

  def stats
    stats = present(stock_service.stats_by_symbol(params[:symbol]), StatsPresenter)
    render partial: "stocks/information_v2/key_stats", locals: { stats: stats }
  end

  def recommendation_trends
    recommendation_trends = present(
      stock_service.recommendation_trends_by_symbol(params[:symbol]),
      RecommendationTrendsPresenter
    )
    render partial: "stocks/information_v2/recommendation_trends",
           locals: { recommendation_trends: recommendation_trends }
  end

  def time_series
    time_series = present(stock_service.time_series_by_symbol(params[:symbol]), TimeSeriesPresenter)
    render partial: "stocks/information_v2/time_series", locals: { time_series: time_series }
  end
end
