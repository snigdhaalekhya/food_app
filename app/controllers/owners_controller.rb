class OwnersController < ApplicationController
    skip_before_action :ensure_user_logged_in

    def create
     owner = findby_params(email: params[:email])
      if owner
         flash[:error]="This email is already registered. Please retry."
         redirect_to new_owner_path 
     else   
          owner=Owner.new(name: params[:name] , email: params[:email] , password: params[:password] ,  address: params[:address])   
           if owner.save
              session[:current_owner_id] = owner.email
              session[:bool_owner] = true
              redirect_to orders1_index_path
            else
               flash[:error] = owner.errors.full_messages.join(", ")
               redirect_to new_owner_path
            end
        end
    end

    private 
    def findby_params(params = {})
        Owner.find_by(params)
    end

end