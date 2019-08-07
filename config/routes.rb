Rails.application.routes.draw do
  get 'rounds/show'
  ActiveAdmin.routes(self)
  devise_for :users

  resources :games do
    resources :rounds
  end

  # In games#new form, fetch kata collections for inspiration
  get "scrape_kata", to: "games#scrape_kata"

  root to: 'games#index'
end
