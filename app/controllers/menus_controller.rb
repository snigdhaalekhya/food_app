class MenusController < ApplicationController 
  include MainHelper

   skip_before_action :ensure_user_logged_in  
   before_action :ensure_owner_logged_in
   before_action :menuwise_category, only: [:category_wise]


    def create
           menu = Menu.new(menu_name:params[:menu_name] , menu_category:params[:menu_category] , menu_cost:params[:menu_cost] , menu_description:params[:menu_description] , menu_image: params[:menu_image] )    
            if menu.save
               redirect_to AllConstants::MENU_ROOT       
            else
               flash[:error] = menu.errors.full_messages.join(", ")
               redirect_to new_menu_path
            end
    end

   
    def edit
      @menu_edit = find_id
    end

    def update 
      menu = find_id
      arr1 = %w(menu.menu_name menu.menu_description menu.menu_category menu.menu_cost menu.menu_image)
      arr2 = %w(params[:menu][:menu_name] params[:menu][:menu_description] params[:menu][:menu_category] params[:menu][:menu_cost]  params[:menu][:menu_image])
      for i in 0..arr1.length
        if arr1[i] != arr2[i]
          case i
          when 0
            menu.update(menu_name: params[:menu][:menu_name])
          when 1
            menu.update(menu_description: params[:menu][:menu_description])
          when 2
            menu.update(menu_category: params[:menu][:menu_category])
          when 3
            menu.update(menu_cost: params[:menu][:menu_cost])
          when 4
            menu.update(menu_image:  params[:menu][:menu_image])
          end
        end 
      end 
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