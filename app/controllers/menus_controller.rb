class MenusController < ApplicationController 
  include MainHelper

   skip_before_action :ensure_user_logged_in  
   before_action :ensure_owner_logged_in
   before_action :category, only: [:category_wise]


    def index 
    end

    def create
           menu = Menu.new(menu_name:params[:menu_name] , menu_category:params[:menu_category] , menu_cost:params[:menu_cost] , menu_description:params[:menu_description] , menu_image: params[:menu_image] )    
            if menu.save
               redirect_to AllConstants::MENU_ROOT       
            else
               flash[:error] = menu.errors.full_messages.join(", ")
               redirect_to new_menu_path
            end
    end

    def new
    end

    def category_wise
      category
    end 



    def edit
      @menu_edit = find_id
    end

    def update
      @menu = Menu.where(id: params[:id])
      @menu.update(menu_name: params[:menu][:menu_name], menu_description: params[:menu][:menu_description], menu_category: params[:menu][:menu_category], menu_cost: params[:menu][:menu_cost], menu_image: params[:menu][:menu_image] )
      redirect_to AllConstants::MENU_ROOT
    end


    def destroy
        find_id.destroy
        redirect_to AllConstants::MENU_ROOT
    end

    private 
    def find_id
     Menu.find(params[:id])
    end
end