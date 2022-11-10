class SessionsResController < ApplicationController 
    skip_before_action :ensure_user_logged_in
   
    def create
      identity = params[:identity]
      if !identity.blank?
        owner = identify_owner_type
        if  owner && owner.authenticate(params[:password])
          session[:current_owner_id] = owner.email
          session[:bool_owner] = false
          redirect_to orders1_index_path
        else
          flash[:error] = "Your login attempt was invalid. Please retry."
          redirect_to new_signin_restaurant_path
        end
      else
        flash[:error] = "Select login type from given radio options"
        redirect_to new_signin_restaurant_path
      end
    end


    def update_password
      identity = params[:identity]
      if !identity.blank?
        owner = identify_owner_type
          if owner
            new_password = params[:password]
            confirm_password = params[:password_confirm]
            if new_password.eql?(confirm_password)
              if new_password == "" && confirm_password == ""
                flash[:error] = "New password and Confirm password couldn't be empty"
                redirect_to signin_restaurant_update_password_path
              else
                owner.password = params[:password]
                owner.save
                redirect_to new_signin_restaurant_path
              end
            else
              flash[:error] = "New password and Confirm password doesn't match"
              redirect_to signin_restaurant_update_password_path
            end
          else
            flash[:error] = "User doesn't exist with this registered email id."
            redirect_to new_owner_path
        end
      else
        flash[:error] = "Select login type from given radio options"
        redirect_to signin_restaurant_update_password_path
      end
    end

    def destroy
        session[:current_owner_id] = nil
        current_owner = nil
        redirect_to new_user_path
    end

    private
    def identify_owner_type
      identity = params[:identity]
        if identity == "Owner"
          owner = Owner.find_by(email: params[:email])
          return owner
        elsif identity == "Worker"
          owner = Worker.find_by(email: params[:email])
          return owner
        end
   end
end
