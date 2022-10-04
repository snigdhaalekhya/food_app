class OwnersController < ApplicationController
    before_action :ensure_owner_logged_in
    skip_before_action :ensure_owner_logged_in
    skip_before_action :ensure_user_logged_in

    def index
    end

    def new
    end

    def create
     owner=Owner.find_by(email: params[:email])
     owner = Owner.owner_create(params[:name], params[:email],params[:password],params[:address])       
     if owner
         flash[:error]="This email is already registered. Please retry."
         redirect_to new_owner_path 
     else
         
          session[:current_owner_id]=owner.email
           if owner.save
              redirect_to "/users/new" 
            else
               flash[:error]= owner.errors.full_messages.join(", ")
               redirect_to new_owner_path
            end
        end
    end
end