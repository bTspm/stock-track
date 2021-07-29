class WatchListsController < ApplicationController
  before_action :require_login

  def index
    @watch_lists = present(watch_list_service.user_watch_lists, WatchListsPresenter)
  end

  def show
    watch_list = present(watch_list_service.watch_list_by_id(params[:id]), WatchListsPresenter)
    stocks = present(stock_service.stocks_for_watch_list(watch_list.symbols), StocksPresenter)
    render partial: "watch_lists/stocks_table", locals: { stocks: stocks, watch_list: watch_list }
  rescue StandardError => e
    render partial: "watch_lists/error", locals: { error: e.message }
  end

  def new
    render partial: "watch_lists/form",
           locals: { companies: company_service.companies_by_symbols(params[:symbol]),
                     method: "POST",
                     path: url_for(action: :create, controller: controller_name),
                     watch_list: Entities::WatchList.new({ symbols: Array.wrap(params[:symbol]&.upcase) })}
  rescue StandardError => e
    render partial: "watch_lists/error", locals: { error: e.message }
  end

  def create
    _save_watch_list
  end

  def edit
    watch_list = watch_list_service.watch_list_by_id(params[:id])
    render partial: "watch_lists/form",
           locals: { companies: company_service.companies_by_symbols(watch_list.symbols),
                     method: "PATCH",
                     path: url_for(action: :update, controller: controller_name, id: watch_list.id),
                     watch_list: watch_list }
  rescue StandardError => e
    render partial: "watch_lists/error", locals: { error: e.message }
  end

  def update
    _save_watch_list
  end

  def destroy
    watch_list_service.delete_watch_list(params[:id])
    redirect_to watch_lists_path
  end

  def add_symbol
    watch_list = watch_list_service.add_symbol_to_watch_list(id: params[:id], symbol: params[:symbol])
    render json: { message: "#{params[:symbol]} is added to #{watch_list.name}", watch_list_id: watch_list.id },
           status: :ok
  rescue StandardError => e
    render json: { message: "Failed adding #{params[:symbol]}. Error: #{e.message}" }, status: :internal_server_error
  end

  def add_to_watch_lists
    watch_lists = present(watch_list_service.user_watch_lists, WatchListsPresenter)
    render partial: "watch_lists/add_to_watch_lists_content", locals: { watch_lists: watch_lists }
  end

  def delete_symbol
    watch_list = watch_list_service.delete_symbol_from_watch_list(id: params[:id], symbol: params[:symbol])
    render json: { message: "#{params[:symbol]} is deleted from #{watch_list.name}", watch_list_id: watch_list.id },
           status: :ok
  rescue StandardError => e
    render json: { message: "Failed deleting #{params[:symbol]}. Error: #{e.message}" }, status: :internal_server_error
  end

  def update_dropdown
    watch_lists = present(watch_list_service.user_watch_lists, WatchListsPresenter)
    render partial: "watch_lists/dropdown", locals: { watch_lists: watch_lists }
  end

  def user_watch_lists_tile
    watch_lists = present(watch_list_service.user_watch_lists, WatchListsPresenter)
    stocks = present(stock_service.stocks_for_watch_list(watch_lists[0].symbols), StocksPresenter) if watch_lists.any?
    render partial: "common/watch_list_tile/watch_list_tile_result", locals: { stocks: stocks, watch_lists: watch_lists }
  end

  def watch_list_stocks_for_tile
    watch_list = present(watch_list_service.watch_list_by_id(params[:id]), WatchListsPresenter)
    stocks = present(stock_service.stocks_for_watch_list(watch_list.symbols), StocksPresenter)
    render partial: "common/watch_list_tile/stock_table", locals: { stocks: stocks }
  end

  private

  def _save_watch_list
    watch_list = watch_list_service.save_watch_list(_watch_list_params)
    render json: { watch_list: watch_list, path: watch_list_path(id: watch_list.id), message: "Save Successful" },
           status: :ok
  rescue AppExceptions::RecordInvalid => e
    render json: { validation_errors: e.error_messages }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { message: "Error saving watchlist. Error: #{e.message}" }, status: :internal_server_error
  end

  def _watch_list_params
    params.permit(:id, :name, symbols: []).tap do |p|
      p[:user_id] = current_user.id
    end
  end
end
