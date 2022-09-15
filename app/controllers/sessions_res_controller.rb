class SessionsResController < ApplicationController 
    skip_before_action :ensure_user_logged_in
    # before_action :ensure_owner_logged_in
    # skip_before_action :ensure_owner_logged_in

    def new
    end
    # def create
    #     owner=Owner.find_by(email: params[:email])
    #     worker=Worker.find_by(email: params[:email])
    #     if owner && owner.authenticate(params[:password]) 
    #          session[:current_owner_id]=owner.id
    #         #debugger
    #         redirect_to orders_restaurant_path
    #     elsif worker && worker.authenticate(params[:password]) 
    #          session[:current_worker_id]=worker.id
    #         #  render plain:worker.id
    #         #debugger
    #          redirect_to orders_restaurant_path
    #    else
    #     flash[:error]="Your login attempt was invalid. Please retry."
    #     redirect_to new_sessions_res_path
    #    end
    # end
    
    def create
      identity= params[:identity]
      if identity
        if identity=="Owner"
           owner=Owner.find_by(email: params[:email])
            if  identity && owner && owner.authenticate(params[:password]) 
                 session[:current_owner_id]=owner.email
                 #debugger
                 redirect_to orders_restaurant_path
             else
                # if identity== nil
                 # flash[:error]="Please Choose login type"
                # end
             flash[:error]="Your login attempt was invalid. Please retry."
            redirect_to new_sessions_res_path
           end
        elsif identity=="Worker"
            owner=Worker.find_by(email: params[:email])
            if  identity && owner && owner.authenticate(params[:password]) 
                 session[:current_owner_id]=owner.email
                #  render plain: session[:current_owner_id]
                 #debugger
                 redirect_to orders_restaurant_path
             else
                # if identity== nil
                #     flash[:error]="Please Choose login type"
                # end
                flash[:error]="Your login attempt was invalid. Please retry."
                redirect_to new_sessions_res_path
           end
        end
      else
        flash[:error]="Select login type from given radio options"
        redirect_to new_sessions_res_path
      end
    end




    def update_password_view
    end

    def update_password
      identity= params[:identity]
      if identity
        if identity=="Owner"
          owner=Owner.find_by(email: params[:email])
          if owner
            new_password=params[:password]
            confirm_password=params[:password_confirm]
            if new_password.eql?(confirm_password)
                 if new_password==""&& confirm_password == ""
                     flash[:error]="New password and Confirm password couldn't be empty"
                     redirect_to signin_restaurant_update_password_path
                 else
                 owner.password=params[:password]
                 owner.save!
                 redirect_to new_sessions_res_path
                 end
            else
                flash[:error]="New password and Confirm password doesn't match"
                redirect_to signin_restaurant_update_password_path
            end
          else 
            flash[:error]="User doesn't exist with this registered email id."
            redirect_to new_owner_path
        end
        elsif identity=="Worker"
          owner=Worker.find_by(email: params[:email])
          if owner
            new_password=params[:password]
            confirm_password=params[:password_confirm]
            if new_password.eql?(confirm_password)
                 if new_password==""&& confirm_password == ""
                     flash[:error]="New password and Confirm password couldn't be empty"
                     redirect_to signin_restaurant_update_password_path
                 else
                 owner.password=params[:password]
                 owner.save!
                 redirect_to new_sessions_res_path
                 end
            else
                flash[:error]="New password and Confirm password doesn't match"
                redirect_to signin_restaurant_update_password_path
            end
          else 
            flash[:error]="User doesn't exist with this registered email id."
            redirect_to new_owner_path
        end
        end
        
      else
        flash[:error]="Select login type from given radio options"
        redirect_to signin_restaurant_update_password_path
      end
    end

    def destroy
        #console.log('------hi-------s')
        if session[:current_owner_id]
          session[:current_owner_id] = nil
          @current_owner = nil
          redirect_to new_user_path
        end
    end
end