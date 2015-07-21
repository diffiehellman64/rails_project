Rails.application.routes.draw do

  resources :articles
  devise_for :users
  root 'home#index'

  namespace :admin do
    resources :users, only: [:index]
    resources :articles, only: [:index] do
      get '/versions' => 'articles#versions'
      get '/versions/:version_time' => 'articles#show'
    end
    resources :roles, only: [:index, :update, :create]
  end

end
