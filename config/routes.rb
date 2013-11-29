Membio::Application.routes.draw do

  resources :items
  resources :lists
  resources :users

  post '/confirm' => "users#confirm", as: 'user_confirm'
  
  root 'users#new'
end