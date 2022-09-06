class OwnersController < ApplicationController
    before_action :ensure_owner_logged_in
    skip_before_action :ensure_owner_logged_in
    skip_before_action :ensure_user_logged_in

    def index
       render plain: "Hello"
    end
    def new
        render "new"
    end

    def create
     owner=Owner.find_by(email: params[:email])
     if owner
         flash[:error]="This email is already registered. Please retry."
         redirect_to new_owner_path 
     else
         owner=Owner.new(
            name: params[:name],
            email: params[:email],
            password: params[:password],
            address: params[:address],
         )
        #  session[:current_user_id]= user.id
           if owner.save
              redirect_to "/users/new" 
            else
               flash[:error]= owner.errors.full_messages.join(", ")
               redirect_to new_owner_path
            end
        end
    end
end