class MenusController < ApplicationController 
  include MainHelper
   skip_before_action :ensure_user_logged_in  
   before_action :ensure_owner_logged_in
   before_action :find_id, only: [:edit , :update , :destroy]


    def index 
    end

    def create
        menu = Menu.menu_create(params[:menu_name] , params[:menu_category] , params[:menu_cost] , params[:menu_description] , params[:menu_image])
            if menu.save
               redirect_to MENU_ROOT        
            else
               flash[:error] = menu.errors.full_messages.join(", ")
               redirect_to new_menu_path
            end
    end

    def new
    end

    def category_wise
      @category = params[:menu_category]
      @menus_category = Menu.where(menu_category: params[:menu_category])
    end 



    def edit
      @menu_edit = find_id
    end

    def update
      menu = find_id
      menu.update(menu_name: params[:menu][:menu_name] , menu_description: params[:menu][:menu_description] , menu_category: params[:menu][:menu_category] , menu_cost: params[:menu][:menu_cost] , menu_image: params[:menu][:menu_image] )
      redirect_to MENU_ROOT
    end


    def destroy
        find_id.destroy
        redirect_to MENU_ROOT
    end

    private 
    def find_id
     Menu.find(params[:id])
    end
end