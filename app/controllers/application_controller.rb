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

    # before_action :ensure_owner_logged_in
    
    def ensure_owner_logged_in
        unless current_owner
             redirect_to new_sessions_res_path
            # render pain: "Not logged in"
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
    # def ensure_worker_logged_in
    #     unless current_worker
    #          redirect_to new_owner_path
    #         # render pain: "Not logged in"
    #     end
    # end

    # def current_worker
    #     return @current_worker if @current_worker

    #     current_worker_id=session[:current_worker_id]
    #     if current_worker_id
    #         @current_worker = Worker.find(current_worker_id)
    #     else
    #         nil
    #     end
    # end
 
    
end
