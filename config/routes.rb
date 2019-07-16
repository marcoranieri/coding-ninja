Rails.application.routes.draw do
  get 'rounds/show'
  ActiveAdmin.routes(self)
  devise_for :users

  resources :games do
    resources :rounds
  end

  root to: 'games#index'
end
