class StocksController < ApplicationController
  def home; end

  def news
    news = present(stock_service.news_by_symbol(params[:symbol]), NewsPresenter)
    render partial: "stocks/information_v2/news", locals: { news: news }
  rescue StandardError => e
    render partial: "stocks/no_content", locals: { error_messages: e.message, header: "News" }
  end

  def time_series
    time_series = present(stock_service.time_series_by_symbol(params[:symbol]), TimeSeriesPresenter)
    render partial: "stocks/information_v2/time_series", locals: { time_series: time_series }
  end

  def information
    # company_service.create_or_update_company_by_symbol("AAPL")
    @company = present(company_service.company_by_symbol(params[:symbol]), CompaniesPresenter)
  end

  def quote
    quote = present(stock_service.quote_by_symbol(params[:symbol]), QuotesPresenter)
    render partial: "stocks/information_v2/quote_information", locals: { quote: quote }
    # rescue StandardError => e
    #   render partial: 'stocks/no_content', locals: {error_messages: e.message}
  end

  def stats
    stats = present(stock_service.stats_by_symbol(params[:symbol]), StatsPresenter)
    render partial: "stocks/information_v2/key_stats", locals: { stats: stats }
  end

  def earnings
    earnings = present(stock_service.earnings_by_symbol(params[:symbol]), EarningsPresenter)
    render partial: "stocks/information_v2/earnings", locals: { earnings: earnings }
  rescue StandardError => e
    render partial: "stocks/no_content", locals: { error_messages: e.message, header: "Earnings" }
  end

  def growth
    growth = present(stock_service.growth_by_symbol(params[:symbol]), GrowthPresenter)
    render partial: "stocks/information_v2/growth", locals: { growth: growth }
  end

  def recommendation_trends
    recommendation_trends = present(
      stock_service.recommendation_trends_by_symbol(params[:symbol]),
      RecommendationTrendsPresenter
    )
    render partial: "stocks/information_v2/recommendation_trends",
           locals: { recommendation_trends: recommendation_trends }
  end
end
