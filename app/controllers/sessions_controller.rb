class SessionsController < ApplicationController 
    skip_before_action :ensure_user_logged_in
    before_action :find_mobileno, only: [:create , :update_password]

    def create
        if params[:mobile_no].blank? || params[:password].blank?
            flash[:error] = "Please fill all the required fields"
             redirect_to new_signin_user_path
        else
        user = find_mobileno
        if user
              if user && user.authenticate(params[:password]) 
                  session[:current_user_id] = user.id
                  session[:bool_user] = false
                  redirect_to main_index_path
              else
                    flash[:error] = "Your login attempt was invalid. Please retry."
                    redirect_to new_signin_user_path
               end
        else
            flash[:error] = "User doesn't exist with this registered mobile number."
            redirect_to new_signin_user_path
        end
    end
end
    

    def new
    end


    def update_password_view
    end

    def update_password
        # debugger
        if params[:mobile_no].blank? || params[:password].blank? || params[:password_confirm].blank?
                flash[:error]="Please fill all the required fields."
                redirect_to signin_users_update_password_path
        else 
            user = find_mobileno
            if user 
                new_password = params[:password]
                confirm_password = params[:password_confirm]
                if new_password.eql?(confirm_password)
                    user.password = params[:password]
                    user.save
                    redirect_to new_signin_user_path
                else
                    flash[:error] = "New password and Confirm password doesn't match"
                    redirect_to signin_users_update_password_path
                end
            else 
                flash[:error] = "User doesn't exist with this registered mobile number."
                redirect_to new_user_path
            end
        end
    end 

    def destroy
        # debugger
        session[:current_user_id] = nil
        current_user = nil
        redirect_to new_user_path
    end

    private 
    def find_mobileno
      User.find_by(mobile_no: params[:mobile_no])
    end
end