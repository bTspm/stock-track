Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "stocks#home"

  namespace :market_movers do
    get :mover
  end

  namespace :stocks do
    get :compare
    get :home
    get :information
    get :search
    get :time_series
  end

  resources :watch_lists do
    collection do
      get :add_to_watch_lists
      get :update_dropdown
      get :user_watch_lists_tile
    end

    member do
      patch :add_symbol
      delete :delete_symbol
      get :watch_list_stocks_for_tile
    end
  end

  require "sidekiq/web"
  require "sidekiq-scheduler/web"
  mount Sidekiq::Web => "/sidekiq"
end
