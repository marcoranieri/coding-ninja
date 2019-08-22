Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  devise_for :users

  resources :games do

    resources :rounds do
      # Ajax call to toggle round.active
      post "toggle", to: "rounds#toggle"
    end

    resources :participations, only: :create # from Games#SHOW

  end

  # In games#new form, fetch kata collections for inspiration
  get "scrape_kata", to: "games#scrape_kata"
  post "webhook", to: "webhooks#handle"

  root to: 'games#index'
end
