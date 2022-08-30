Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/view_restaurant" => "home#index"
  get "/view_user" => "main#index"
  get "/orders_restaurant" => "orders#index"
  get "/menu_restaurant" => "menus#index"
  get "/users_restaurant" => "users#index"
  get "/reports_restaurant" => "reports#index"
  get "/" => "users#new"
  get "/carts/:id/remove"  => "carts#remove", as: :remove
  resources :users
  resources :owners
  resources :menus
  resources :carts
  #users(Customers)
  get "/signin_users" => "sessions#new", as: :new_sessions
  post "/signin_users" => "sessions#create", as: :sessions
  delete "/signout_users" => "sessions#destroy", as: :destroy_session
  #users_res(Restaurant Owners)
  get "/signin_restaurant" => "sessions_res#new", as: :new_sessions_res
  post "/signin_restaurent" => "sessions_res#create", as: :sessions_res
end
