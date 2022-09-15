class MenusController < ApplicationController 
   skip_before_action :ensure_user_logged_in  
   before_action :ensure_owner_logged_in

    def index   
      if Owner.find_by(email: current_owner.email)
        @owner_worker= current_owner.email
      elsif Worker.find_by(email: current_owner.email)
        @owner_worker= current_owner.email
      end  
    end

    def create
        menu=Menu.new(
            menu_name: params[:menu_name],
            menu_category: params[:menu_category],
            menu_cost: params[:menu_cost],
            menu_description: params[:menu_description],
          )
        #  session[:current_owner_id]= owner.id
           if menu.save
              redirect_to "/menu_restaurant" 
        #response_text= "new todo #{new_todo.id}"
        #render plain:  response_text
            else
               flash[:error]= menu.errors.full_messages.join(", ")
               redirect_to "/menus/new"
            end
    end

    def new
      id= params[:id]
      menu=Menu.find_by(id)
    end

    #get
    def category_wise
      @category=params[:menu_category]
      @menus_category= Menu.where(menu_category: params[:menu_category])
    end 
    
end