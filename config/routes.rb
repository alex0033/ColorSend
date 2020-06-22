Rails.application.routes.draw do
  root 'basic_pages#home'
  devise_for :users, controllers: {
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :registrations      => 'users/registrations',
    :sessions           => 'users/sessions'
  }
  resources :users,      only: [:index, :show]
  resources :microposts, only: [:new, :create, :show, :destroy]
  get   'passwords/edit'
  patch 'passwords/update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
