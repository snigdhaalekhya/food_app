class MainController < ApplicationController
    skip_before_action :ensure_user_logged_in
    # skip_before_action :ensure_owner_logged_in

    def index
        @carts= Cart.of_user(current_user)
        # @search=Menu.search(params[:search])
        if params[:search].blank?
        #   redirect_to view_user_path
        else
            @results=Menu.search(params[:search])
             @parameter= params[:search]
            #  @results= Menu.where("lower(menu_name) LIKE ?",search: "%#{@parameter}%")
        end
    end
    def new
    end

    #get
    def category_wise
        @carts= Cart.of_user(current_user)
        @category=params[:menu_category]
        @menus_category= Menu.where(menu_category: params[:menu_category])
    end 
end