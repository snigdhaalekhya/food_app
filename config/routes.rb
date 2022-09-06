Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/view_restaurant" => "home#index"

  #for Customer side adding +,- items to cart
  get "/view_user" => "main#index"

  #for Restaurant side orders
  get "/orders_restaurant" => "orders1#index"
     get "/all_orders" => "orders1#all_orders"
     get "/completed_orders" => "orders1#completed_orders"
  get "/menu_restaurant" => "menus#index"
  get "/users_restaurant" => "users#index"
  get "/reports_restaurant" => "reports#index"
  get "/" => "users#new"
  get "/carts/:id/remove"  => "carts#remove", as: :remove
  resources :users
  resources :owners
  resources :menus
  resources :carts
  resources :orders1
  resources :workers
  #for Customer side orders
  resources :orders


  #users(Customers)
  get "/signin_users" => "sessions#new", as: :new_sessions
  post "/signin_users" => "sessions#create", as: :sessions
  delete "/signout_users" => "sessions#destroy", as: :destroy_session


  #users_res(Restaurant Owners)
  get "/signin_restaurant" => "sessions_res#new", as: :new_sessions_res
  post "/signin_restaurent" => "sessions_res#create", as: :sessions_res
end
