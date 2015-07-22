Rails.application.routes.draw do

  resources :articles
  root 'home#index'

  devise_for :users

  namespace :admin do
    resources :users, only: [:index]
    get '/versions/:item_type' => 'versions#index'
    get '/versions/:item_type/:item_id' => 'versions#show'
    get '/versions/:item_type/:item_id/:version_id' => 'versions#version'
    patch '/versions/:item_type/:item_id/:version_id' => 'versions#rollback'
    delete '/versions/:item_type/:item_id/:version_id' => 'versions#destroy'
    resources :articles, only: [:index] 
    resources :roles, only: [:index, :update, :create]
  end

end
