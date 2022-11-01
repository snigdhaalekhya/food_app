Rails.application.routes.draw do
  
  get "/rough" => "reports#rough"
  get "/rough1" => "reports#rough1"
  
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
  delete "/button_property SignOut_users" => "sessions#destroy", as: :destroy_session

  get"/signin_restaurant/update_password" =>"sessions_res#update_password_view"
  post"/signin_restaurant/update_password" =>"sessions_res#update_password"
  delete "/button_property SignOut_restaurant" => "sessions_res#destroy", as: :destroy_session_res

  get"/view_user/category_wise" =>"main#category_wise"

  get"/menus/category_wise" =>"menus#category_wise"
 
  get "/carts/:id/remove"  => "carts#remove", as: :remove

  get "/show_customers" =>"workers#show_customers"

  get "/user_active_orders" => "orders#active_orders"
  get "/user_completed_orders" => "orders#completed_orders"

  get "/all_orders" => "orders_res#all_orders"
  get "/completed_orders" => "orders_res#completed_orders"

end



