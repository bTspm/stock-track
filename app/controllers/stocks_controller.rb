class StocksController < ApplicationController
  def compare
    compare_symbols = params[:symbols]
    stocks = stock_service.stocks_for_compare(compare_symbols)
    @stocks = present(stocks, StocksPresenter)
  end

  def home; end

  def information
    @stock = present(stock_service.stock_info_by_symbol(params[:symbol]), StocksPresenter)
  end

  def search
    companies = present(company_service.basic_search(params[:query]), CompaniesPresenter)
    render json: { suggestions: companies.search_response }
  end

  def time_series
    time_series = present(stock_service.time_series_by_symbol(params[:symbol]), TimeSeriesPresenter)
    render partial: "stocks/information_v2/time_series", locals: { time_series: time_series }
  end
end
