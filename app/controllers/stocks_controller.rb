class StocksController < ApplicationController
  def home; end

  def information
    @stock = present(stock_service.stock_info_by_symbol(params[:symbol]), StocksPresenter)
  end

  def time_series
    time_series = present(stock_service.time_series_by_symbol(params[:symbol]), TimeSeriesPresenter)
    render partial: "stocks/information_v2/time_series", locals: { time_series: time_series }
  end
end
