class SessionsResController < ApplicationController 
    skip_before_action :ensure_user_logged_in
    before_action :ensure_owner_logged_in
    skip_before_action :ensure_owner_logged_in

    def new
    end
    def create
        owner=Owner.find_by(email: params[:email])
        if owner && owner.authenticate(params[:password]) 
            # session[:current_owner_id]=owner.id
            #debugger
            redirect_to orders_restaurant_path
       else
        flash[:error]="Your login attempt was invalid. Please retry."
        redirect_to new_sessions_res_path
       end
    end

    def destroy
        #console.log('------hi-------s')
        session[:current_owner_id] = nil
        @current_owner = nil
        redirect_to home_path
    end
end