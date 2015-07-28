Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :menus, only: [:index, :new, :create]
  get 'menus/:menu_name' => 'menus#show', as: 'menu'

  resources :articles
  root 'home#index'

  devise_for :users , controllers: { registrations: 'access/registrations',
                                     passwords: 'access/passwords',
                                     sessions: 'access/sessions' }
  devise_scope :user do
    get    'profile/:id' => 'access/registrations#profile', as: 'profile'
    get    'users/all' => 'access/registrations#users'
    post   'users/validate' => 'access/registrations#validate', as: :users_validation
    patch  'users/:id/:act/:role' => 'access/registrations#roles_update', as: 'update_user_role'
  end

  scope :versions do
    get    '/:item_type' => 'versions#index', as: 'versions'
    get    '/:item_type/:item_id' => 'versions#show', as: 'versions_item'
    get    '/:item_type/:item_id/:version_id' => 'versions#version', as: 'version_show'
    patch  '/:item_type/:item_id/:version_id' => 'versions#rollback', as: 'version_rollback'
    delete '/:item_type/:item_id/:version_id' => 'versions#destroy' , as: 'version_destroy'
  end

end
