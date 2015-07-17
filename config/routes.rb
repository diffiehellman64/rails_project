Rails.application.routes.draw do

  resources :articles
  devise_for :users
  root 'home#index'

  namespace :admin do
    resources :users, only: [:index]
    resources :roles, only: [:index, :update, :create]
  end

end
