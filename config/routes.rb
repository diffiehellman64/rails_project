Rails.application.routes.draw do

  resources :articles
  root 'home#index'

  devise_for :users , controllers: { registrations: 'access/registrations', 
                                     passwords: 'access/passwords',
                                     sessions: 'access/sessions' }
  devise_scope :user do
    get    'profile/:id' => 'access/registrations#profile', as: 'profile'
    get    'users/all' => 'access/registrations#users'
    patch  'users/:id/:act/:role' => 'access/registrations#roles_update', as: 'update_user_role'
  end

  namespace :admin do
    get    '/versions/:item_type' => 'versions#index', as: 'versions'
    get    '/versions/:item_type/:item_id' => 'versions#show'
    get    '/versions/:item_type/:item_id/:version_id' => 'versions#version', as: 'version_show'
    patch  '/versions/:item_type/:item_id/:version_id' => 'versions#rollback', as: 'version_rollback'
    delete '/versions/:item_type/:item_id/:version_id' => 'versions#destroy' , as: 'version_destroy'
  end

end
