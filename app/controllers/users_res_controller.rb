class UsersResController < ApplicationController
    skip_before_action :ensure_user_logged_in
    before_action :ensure_owner_logged_in
    
    def index
        if Owner.find_by(email: current_owner.email)
            @owner_worker= current_owner.email
        elsif Worker.find_by(email: current_owner.email)
            @owner_worker= current_owner.email
        end
        render "index"
    end 
end