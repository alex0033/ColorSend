Rails.application.routes.draw do
  root 'basic_pages#home'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_for :users, controllers: {
  #       sessions: 'users/sessions'
  #     }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
