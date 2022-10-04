class MenusController < ApplicationController 
   skip_before_action :ensure_user_logged_in  
   before_action :ensure_owner_logged_in
  
    def index   

    end

    def create
        menu = Menu.menu_create(params[:menu_name],params[:menu_category],params[:menu_cost], params[:menu_description],params[:menu_image])
           if menu.save
              redirect_to "/menu_restaurant" 
       
            else
               flash[:error]= menu.errors.full_messages.join(", ")
               redirect_to "/menus/new"
            end
    end

    def new
    end

    def category_wise
      @category=params[:menu_category]
      @menus_category= Menu.where(menu_category: params[:menu_category])
    end 



    def edit
      @menu_edit=Menu.find(params[:id])
    end

    def update
      @menu=Menu.find(params[:id])
      @menu.update(menu_name: params[:menu][:menu_name], menu_description: params[:menu][:menu_description], menu_category: params[:menu][:menu_category], menu_cost: params[:menu][:menu_cost], menu_image: params[:menu][:menu_image] )
      redirect_to "/menu_restaurant"
    end


    def destroy
        menu_delete=Menu.find(params[:id])
        menu_delete.destroy
        redirect_to "/menu_restaurant"
    end
    
  # private
  #   def post_params
  #     params.require(:post).permit(:menu_name, :menu_description, :menu_cost, :menu_category,:menu_image)
  #   end
end