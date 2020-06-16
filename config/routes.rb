Rails.application.routes.draw do
  root 'basic_pages#home'
  devise_for :users, controllers: {
    #:omniauth_callbacks => 'users/omniauth_callbacks'
    :registrations => 'users/registrations'
  }

  get 'user_displays/show'
  get 'user_displays/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
