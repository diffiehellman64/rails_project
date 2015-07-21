Rails.application.routes.draw do

  resources :articles
  devise_for :users
  root 'home#index'

  namespace :admin do
    resources :users, only: [:index]
    get '/versions/:item_type' => 'versions#index'
#    get '/versions/:item_type/:item_id/:version_time' => 'articles#versions'
#    get '/versions/:item_type/:item_id/:version_time' => 'articles#versions'
    resources :articles, only: [:index] 
#    do
#      get '/versions' => 'articles#versions'
#      get '/versions/:version_time' => 'articles#show'
#      post '/versions/:version_time' => 'articles#rollback'
#    end
    resources :roles, only: [:index, :update, :create]
  end

end
