Rails.application.routes.draw do

  resources :articles
  root 'home#index'

  devise_for :users , controllers: { registrations: 'access/registrations', 
                                     passwords: 'access/passwords',
                                     sessions: 'access/sessions' }
  devise_scope :user do
    get 'profile/:id' => 'access/registrations#profile', as: 'profile'
  end

  namespace :admin do
    resources :users, only: [:index]
    get '/versions/:item_type' => 'versions#index'
    get '/versions/:item_type/:item_id' => 'versions#show'
    get '/versions/:item_type/:item_id/:version_id' => 'versions#version', as: 'version_show'
    patch '/versions/:item_type/:item_id/:version_id' => 'versions#rollback', as: 'version_rollback'
    delete '/versions/:item_type/:item_id/:version_id' => 'versions#destroy' , as: 'version_destroy'
    resources :articles, only: [:index] 
    resources :roles, only: [:index, :update, :create]
  end

end
