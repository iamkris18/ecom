require 'sidekiq/web'
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == 'password' 
end


Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "sessions#new"

   get '/products', to: 'products#index'

   get '/products/:id', to: 'products#show', as: 'product'

   get '/login', to: 'sessions#new', as: 'login'
   post '/login', to: 'sessions#create'

   get '/logout', to: 'sessions#destroy'

   get '/cart', to: 'cart#show', as: 'cart'
   post '/cart/add/:product_id', to: 'cart#add', as: 'add_to_cart'

   get '/profile', to: 'users#profile', as: 'profile'
   patch '/profile', to: 'users#update'

   
  patch '/profile/update_email', to: 'sessions#update_email', as: 'update_email_user'
  patch '/profile/update', to: 'sessions#update_profile', as: 'update_profile_user'

  delete 'cart/remove/:id', to: 'cart#destroy', as: 'remove_item'
   mount Sidekiq::Web => '/sidekiq'

  
  
end
