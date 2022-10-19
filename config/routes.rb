Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # get "/view_restaurant" => "home#index"


  get "/rough" => "reports#rough"
  get "/rough1" => "reports#rough1"
  #for Customer side adding +,- items to cart
  # get "/view_user" => "main#index"
  #     get"/view_user/category_wise" =>"main#category_wise"

  #for Restaurant side ordersp
  # get "/orders1" => "orders1#index"
    #  get "/all_orders" => "orders1#all_orders"
    #  get "/completed_orders" => "orders1#completed_orders"
  # get "/menu_restaurant" => "menus#index"
    # get"/menus/category_wise" =>"menus#category_wise"
    # get "/view_user/search" => "menus#search"

  # get "/reports" => "reports#index"
      #  get "/reports/customer_orders_view" => "reports#customer_orders_view"
      #  post "/reports/customer_orders" => "reports#customer_orders"
  #  get "/" => "users#new"
  # get "/carts/:id/remove"  => "carts#remove", as: :remove
  # resources :users
  # resources :owners
  # resources :menus
  # resources :carts
  # resources :orders1
  # resources :workers
    # get "/show_customers" =>"workers#show_customers"
  #for Customer side orders
  # resources :orders
  #  get "/user_active_orders" => "orders#active_orders"
  #  get "/user_completed_orders" => "orders#completed_orders"
  #users(Customers)
  # get "/signin_users" => "sessions#new", as: :new_sessions
  # post "/signin_users" => "sessions#create", as: :sessions
  # get"/signin_users/update_password" =>"sessions#update_password_view"
  # post"/signin_users/update_password" =>"sessions#update_password"
  # delete "/signout_users" => "sessions#destroy", as: :destroy_session


  # users_res(Restaurant Owners)
  # get "/signin_restaurant" => "sessions_res#new", as: :new_sessions_res
  # post "/signin_restaurant" => "sessions_res#create", as: :sessions_res
  # get"/signin_restaurant/update_password" =>"sessions_res#update_password_view"
  # post"/signin_restaurant/update_password" =>"sessions_res#update_password"
  # delete "/signout_restaurant" => "sessions_res#destroy", as: :destroy_session_res


  get "/" => "users#new"

  resources :users , controller: 'users', :only => [:new, :create] 
  resources :owners , controller: 'owners', :only => [:index, :new, :create] 
  resources :signin_users , controller: 'sessions', :only => [:new, :create] 
  resources :signin_restaurant , controller: 'sessions_res', :only => [:new, :create] 
  resources :main , controller: 'main', :only => [:index]
  resources :menus , controller: 'menus', :only => [:index,:new, :create,:edit,:update,:destroy] 
  resources :carts , controller: 'carts', :only => [:index,:show] 
  resources :workers , controller: 'workers', :only => [:index,:create,:new] 
  resources :reports , controller: 'reports', :only => [:index] 
  resources :orders , controller: 'orders', :only => [:index,:create,:update] 
  resources :orders1 , controller: 'orders_res', :only => [:index,:update] 

  get"/signin_users/update_password" =>"sessions#update_password_view"
  post"/signin_users/update_password" =>"sessions#update_password"
  delete "/signout_users" => "sessions#destroy", as: :destroy_session

  get"/signin_restaurant/update_password" =>"sessions_res#update_password_view"
  post"/signin_restaurant/update_password" =>"sessions_res#update_password"
  delete "/signout_restaurant" => "sessions_res#destroy", as: :destroy_session_res

  get"/view_user/category_wise" =>"main#category_wise"

  get"/menus/category_wise" =>"menus#category_wise"
 
  get "/carts/:id/remove"  => "carts#remove", as: :remove

  get "/show_customers" =>"workers#show_customers"

  get "/user_active_orders" => "orders#active_orders"
  get "/user_completed_orders" => "orders#completed_orders"

  get "/all_orders" => "orders_res#all_orders"
  get "/completed_orders" => "orders_res#completed_orders"

  # params =  {controller:'sessions_res' , action: update_password,create }

end



# params =  {controller: , action: update_password }