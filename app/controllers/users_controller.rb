class UsersController < ApplicationController
    # skip_before_action :ensure_user_logged_in

    def new
        render "new"
    end

    def create
     user=User.find_by(mobile_no: params[:mobile_no])
     if user
         flash[:error]="This mobile number is already registered. Please retry."
         #redirect_to new_user_path 
     else
         user=User.create!(
            name: params[:name],
            mobile_no: params[:mobile_no],
            password: params[:password],
            address: params[:address],
         )
        #  session[:current_user_id]= user.id
        #    if user.save
        #       redirect_to "/" 
        #     else
        #        flash[:error]= user.errors.full_messages.join(", ")
        #        redirect_to new_user_path
        #     end
        end
    end
end