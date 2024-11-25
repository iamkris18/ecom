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

   get '/signup', to: 'sessions#signup', as: 'signup'
   post '/signup', to: 'sessions#create_user'

   get '/logout', to: 'sessions#destroy'

   get '/cart', to: 'cart#show', as: 'cart'
   post '/cart/add/:product_id', to: 'cart#add', as: 'add_to_cart'
   delete 'cart_items/:id', to: 'cart#remove', as: 'remove_cart_item'


   get '/profile', to: 'users#profile', as: 'profile'
   patch '/profile', to: 'users#update'

   
  patch '/profile/update', to: 'sessions#update_profile', as: 'update_profile_user'

  post '/cart/invoice', to: 'cart#generate_invoice', as: :generate_invoice


   mount Sidekiq::Web => '/sidekiq'
  
end
