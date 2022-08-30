class MainController < ApplicationController
    skip_before_action :ensure_user_logged_in
    def index
        @carts= Cart.of_user(current_user)
        render "index"
    end
    def new
    end
end