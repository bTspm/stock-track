Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "stocks#home"

  namespace :stocks do
    get :earnings
    get :growth
    get :home
    get :information
    get :news
    get :quote
    get :recommendation_trends
    get :stats
    get :time_series
  end

  namespace :search do
    get :basic
    get :search_for_dropdown
  end

  resources :watch_lists do
    collection do
      get :update_dropdown
    end
  end

  require "sidekiq/web"
  require "sidekiq-scheduler/web"
  mount Sidekiq::Web => "/sidekiq"
end
