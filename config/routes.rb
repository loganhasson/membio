Membio::Application.routes.draw do

  resources :items
  resources :lists
  resources :users

  post '/confirm' => "users#confirm", as: 'user_confirm'
  get '/texts/twilio' => "texts#parse", as: 'parse_texts'

  root 'users#new'
end