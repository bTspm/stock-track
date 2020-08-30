class WatchListsController < ApplicationController
  before_action :require_login

  def new
    render partial: "watch_lists/form",
           locals: { method: "POST", path: url_for(action: :create, controller: controller_name) }
  rescue StandardError => e
    render partial: "watch_lists/error", locals: { error: e.message }
  end

  def create
    _create_or_update
  end

  def edit
    watch_list = watch_list_service.user_watch_list_by_id(params[:id])
    render partial: "watch_lists/form",
           locals: { companies: company_service.by_symbols(watch_list.symbols),
                     method: "PATCH",
                     path: url_for(action: :update, controller: controller_name, id: watch_list.id),
                     watch_list: watch_list }
  rescue StandardError => e
    render partial: "watch_lists/error", locals: { error: e.message }
  end

  def update
    _create_or_update
  end

  def show
    watch_list = present(watch_list_service.user_watch_list_by_id(params[:id]), WatchListsPresenter)
    stocks = present(stock_service.stocks_by_symbols(watch_list.symbols), StocksPresenter)
    render partial: "watch_lists/watch_list_information", locals: { stocks: stocks, watch_list: watch_list }
  rescue StandardError => e
    render partial: "watch_lists/error", locals: { error: e.message }
  end

  def index
    @watch_lists = present(watch_list_service.user_watch_lists, WatchListsPresenter)
  end

  def update_dropdown
    watch_lists = present(watch_list_service.user_watch_lists, WatchListsPresenter)
    render partial: "watch_lists/dropdown", locals: { watch_lists: watch_lists, selected_id: params[:selected_id] }
  end

  def destroy
    WatchList.where(id: params[:id], user_id: current_user.id).first&.destroy
    redirect_to watch_lists_path
  end

  private

  def _create_or_update
    watch_list = watch_list_service.create_or_update(_watch_list_params)
    render json: { watch_list: watch_list, path: watch_list_path(id: watch_list.id) }, status: :ok
  end

  def _watch_list_params
    params.permit(:id, :name, symbols: []).tap do |p|
      p[:user_id] = current_user.id
    end
  end
end
