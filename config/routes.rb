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
    end

    member do
      patch :add_symbol
      delete :delete_symbol
    end
  end

  require "sidekiq/web"
  require "sidekiq-scheduler/web"
  mount Sidekiq::Web => "/sidekiq"
end
