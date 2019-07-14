Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users

  resources :games

  root to: 'games#index'
end
