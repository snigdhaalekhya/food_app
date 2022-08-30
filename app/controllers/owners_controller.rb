class OwnersController < ApplicationController
     skip_before_action :ensure_user_logged_in
    def index
       render plain: "Hello"
    end
    def new
        render "new"
    end

    def create
     user_res=UserRes.find_by(email: params[:email])
     if user_res
         flash[:error]="This mobile number is already registered. Please retry."
         redirect_to new_owner_path 
     else
         user_res=UserRes.new(
            name: params[:name],
            email: params[:email],
            password: params[:password],
            address: params[:address],
         )
        #  session[:current_user_id]= user.id
           if user_res.save
              redirect_to "/" 
            else
               flash[:error]= user_res.errors.full_messages.join(", ")
               redirect_to new_owner_path
            end
        end
    end
end