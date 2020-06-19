Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  root 'basic_pages#home'
  devise_for :users, controllers: {
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :registrations      => 'users/registrations',
    :sessions           => 'users/sessions'
  }
  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
