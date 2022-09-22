class ApplicationController < ActionController::Base
    before_action :ensure_user_logged_in
    # before_action :ensure_owner_logged_in
    
    def ensure_user_logged_in
        unless current_user
            redirect_to "/"
        end
    end

    def current_user
        return @current_user if @current_user

        current_user_id=session[:current_user_id]
        if current_user_id
            @current_user = User.find(current_user_id)
        else
            nil
        end
    end

   
    
    def ensure_owner_logged_in
        unless current_owner
            redirect_to new_owner_path
        end
    end

    def current_owner
        return @current_owner if @current_owner

        current_owner_id=session[:current_owner_id]
        if current_owner_id
            if Owner.find_by(email: current_owner_id)
                @current_owner= Owner.find_by(email: current_owner_id)
            elsif Worker.find_by(email: current_owner_id)
                @current_owner= Worker.find_by(email: current_owner_id)
            end
        else
            nil
        end
    end
    
    
end
