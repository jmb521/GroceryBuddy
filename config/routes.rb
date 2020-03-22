Rails.application.routes.draw do
  root to: 'application#home'
  resources :items
  resources :businesses
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  
  # get '/search' => 'businesses#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
