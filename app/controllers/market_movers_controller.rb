class MarketMoversController < ApplicationController
  def mover
    stocks = present(stock_service.market_movers_by_key(params[:key].to_sym), StocksPresenter)
    render partial: "stocks_table", locals: { stocks: stocks }
  end
end
