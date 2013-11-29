Membio::Application.routes.draw do

  resources :items
  resources :lists
  resources :users

  root 'users#new'
end