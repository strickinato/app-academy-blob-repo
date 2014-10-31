Rails.application.routes.draw do
  resources :users, only: [:create, :show, :new]
  resource :session, only: [:new, :create, :destroy]

  resources :bands
  resources :albums
  resources :tracks

  resources :notes, only: [:create]
end
