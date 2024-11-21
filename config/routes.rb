Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
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

  
  
end
