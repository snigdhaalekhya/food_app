class UsersController < ApplicationController
    skip_before_action :ensure_user_logged_in
    
    def new
    end

    def create
     user = findby_params(mobile_no: params[:mobile_no])
     if user
         flash[:error] = "This mobile number is already registered. Please retry."
         redirect_to new_user_path 
     elsif findby_params(email: params[:email])
         flash[:error] = "This email is already registered. Please retry."
          redirect_to new_user_path 
     else
        user = User.user_create(params[:name] , params[:mobile_no] , params[:email] , params[:password] , params[:address])
          session[:current_user_id] = user.id
           if user.save
              redirect_to new_signin_user_path 
            else
               flash[:error] = user.errors.full_messages.join(", ")
               redirect_to new_user_path
            end
        end
    end

    private 
    def findby_params(params = {})
        User.find_by(params)
    end
    
end