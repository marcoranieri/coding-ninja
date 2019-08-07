Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users

  resources :games do
    resources :rounds
    resources :participations, only: :create # from Games#SHOW
  end

  # In games#new form, fetch kata collections for inspiration
  get "scrape_kata", to: "games#scrape_kata"

  root to: 'games#index'
end
