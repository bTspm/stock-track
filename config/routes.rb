Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "stocks#home"

  namespace :stocks do
    get :home
    get :information
    get :news
    get :company
    get :create_or_update_company_by_symbol
    get :time_series
    get :earnings
    get :recommendation_trends
    get :quote
    get :stats
    get :growth
  end
end
