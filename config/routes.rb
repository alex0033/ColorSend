Rails.application.routes.draw do

  root 'basic_pages#home'
  get  'search'      => 'basic_pages#search'
  get  'user_policy' => 'basic_pages#user_policy'

  devise_for :users, controllers: {
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :registrations      => 'users/registrations'
  }

  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
  end

  resources :notifications, only: [:index] do
    collection do
      delete :all_destroy
    end
  end

  resources :microposts,    only: [:new, :create, :show, :destroy]
  resources :comments,      only: [:create, :destroy]
  resources :likes,         only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  get   'passwords/edit'
  patch 'passwords/update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
