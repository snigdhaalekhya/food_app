class ApplicationController < ActionController::Base
    before_action :ensure_user_logged_in

    def ensure_user_logged_in
        unless current_user
            redirect_to "/"
        end
    end
  
    def current_user
        return @current_user if @current_user

        current_user_id = session[:current_user_id]
        @check_firstlogin_user = session[:bool_user] 
        @current_user = User.find(current_user_id) if current_user_id.present?
    end

   
    
    def ensure_owner_logged_in
        unless current_owner
            redirect_to new_owner_path
        end
    end

    def current_owner
        return @current_owner if @current_owner

        current_owner_id = session[:current_owner_id]
        @check_firstlogin_owner = session[:bool_owner] 
        @current_owner = check if current_owner_id.present?
    end
    
        
    define_method "check"  do
          [Owner, Worker].each do |model|
               if model.find_by(email: session[:current_owner_id]).present?
                  current = model.find_by(email: session[:current_owner_id])
                  @model = model
                  return current
               end
          end
    end

    def category
        # debugger
        @category = params[:menu_category]
        @menus_category = Menu.where(menu_category: @category) 
    end
   
end
