class SessionsController < ApplicationController 
    skip_before_action :ensure_user_logged_in
    # skip_before_action :ensure_owner_logged_in
    
    def new
    end
    def create
        user=User.find_by(mobile_no: params[:mobile_no])
        if user && user.authenticate(params[:password]) 
            session[:current_user_id]=user.id
            #debugger
            redirect_to view_user_path
       else
        flash[:error]="Your login attempt was invalid. Please retry."
        redirect_to new_sessions_path
       end
    end

    def destroy
        #console.log('------hi-------s')
        session[:current_user_id] = nil
        @current_user = nil
        redirect_to new_user_path
    end
end