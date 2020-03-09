Rails.application.routes.draw do
  devise_for :users
  resources :favoriets, only: [:create, :destroy] 
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  root 'home#top'
  get 'home/about'
end