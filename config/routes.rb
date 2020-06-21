Rails.application.routes.draw do
  get 'microposts/new'
  get 'microposts/show'
  root 'basic_pages#home'
  devise_for :users, controllers: {
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :registrations      => 'users/registrations',
    :sessions           => 'users/sessions'
  }
  resources :users,     only: [:index, :show]
  get   'passwords/edit'
  patch 'passwords/update'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
