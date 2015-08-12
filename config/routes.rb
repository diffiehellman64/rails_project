Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :menus, only: [:index, :new, :create, :update, :destroy]
  resources :galleries
  # post   '/gallery/add_image'     => 'galleries#add_image', as: 'images'
  delete '/gallery/del_image/:image_id' => 'galleries#del_image', as: 'del_image'
  resources :letters


  get  'menus/:menu_name' => 'menus#show', as: 'menu_show'
  # post 'menus/:menu_name' => 'menus#create'

  resources :articles
  root 'home#index'

  devise_for :users , controllers: { registrations: 'access/registrations',
                                     passwords: 'access/passwords',
                                     sessions: 'access/sessions' }
  devise_scope :user do
    get    'profile/:id' => 'access/registrations#profile', as: 'profile'
    patch  'users/:id/update' => 'access/registrations#user_update', as: 'user_update'
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
