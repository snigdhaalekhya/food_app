class HomeController < ApplicationController
    skip_before_action :ensure_user_logged_in
    

    def index
        render plain: ensure_user_logged_in
    end 
end