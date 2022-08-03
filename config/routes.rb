Rails.application.routes.draw do
  devise_for :users
  resources :words
 
  
  #get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'home/about'
  root 'home#index'
  
  get '/words', to: 'word#index'
  post '/word', to: 'word#new'
  get '/error', to: 'word#error'
end
