Rails.application.routes.draw do
  devise_for :users

  root "dashboard#index"

  resources :expenses, only: [:index, :new, :create, :show]
  resources :friends,  only: [:show]
  resources :payments, only: [:new, :create]
end
