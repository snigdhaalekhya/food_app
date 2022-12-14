class UsersController < ApplicationController
    skip_before_action :ensure_user_logged_in
    
    def index
        render "index"
    end 
    
    def new
        render "new"
    end

    def create
     user=User.find_by(mobile_no: params[:mobile_no])
     if user
         flash[:error]="This mobile number is already registered. Please retry."
         redirect_to new_user_path 
     elsif User.find_by(email: params[:email])
         flash[:error]="This email is already registered. Please retry."
          redirect_to new_user_path 
     else
         user=User.new(
            name: params[:name],
            mobile_no: params[:mobile_no],
            email: params[:email],
            password: params[:password],
            address: params[:address],
         )
          session[:current_user_id]= user.id
           if user.save
              redirect_to new_sessions_path 
            else
               flash[:error]= user.errors.full_messages.join(", ")
               redirect_to new_user_path
            end
        end
    end
end