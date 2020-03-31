class StocksController < ApplicationController
  def home
  end

  def create_or_update_company_by_symbol
    company_service.create_or_update_company_by_symbol(params[:symbol])
    redirect_to stocks_information_path(symbol: params[:symbol])
  end

  def news
    news = present(stock_service.news_by_symbol(params[:symbol]), NewsPresenter)
    render partial: 'stocks/information_v2/news', locals: { news: news }
  end

  def chart
    time_series = present(stock_service.time_series(params[:symbol]), TimeSeriesPresenter)
    render partial: 'stocks/information_v2/chart', locals: { time_series: time_series }
  end

  def information
    @stock = present(stock_service.stock_by_symbol(params[:symbol]), StocksPresenter)
  end

  def earnings
    earnings = present(stock_service.earnings_by_symbol(params[:symbol]), EarningsPresenter)
    render partial: 'stocks/information_v2/earnings', locals: { earnings: earnings }
  end

  def recommendation_trends
    recommendation_trends = present(stock_service.recommendation_trends(params[:symbol]), RecommendationTrendsPresenter)
    render partial: 'stocks/information_v2/recommendation_trends', locals: { recommendation_trends: recommendation_trends }
  end
end
