class SessionsController < ApplicationController 
    before_action :ensure_user_logged_in
    skip_before_action :ensure_user_logged_in
    # include ApplicationHelper

    def create
        user=User.find_by(mobile_no: params[:mobile_no])
        if user && user.authenticate(params[:password]) 
            session[:current_user_id]=user.id
            redirect_to view_user_path
       else
        flash[:error]="Your login attempt was invalid. Please retry."
        redirect_to new_sessions_path
       end
    end
    

    def new
    end


    def update_password_view
    end

    def update_password
        user=User.find_by(mobile_no: params[:mobile_no])
        if user
            new_password=params[:password]
            confirm_password=params[:password_confirm]
            if new_password.eql?(confirm_password)
                 if new_password==""&& confirm_password == ""
                     flash[:error]="New password and Confirm password couldn't be empty"
                     redirect_to signin_users_update_password_path
                 else
                 user.password=params[:password]
                 user.save!
                 redirect_to new_sessions_path
                 end
            else
                flash[:error]="New password and Confirm password doesn't match"
                redirect_to signin_users_update_password_path
            end
        else 
            flash[:error]="User doesn't exist with this registered mobile number."
            redirect_to new_user_path
        end
    end 

    def destroy
        session[:current_user_id] = nil
        current_user = nil
        redirect_to new_user_path
    end
end