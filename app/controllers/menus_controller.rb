class MenusController < ApplicationController 
    #skip_before_action :ensure_user_logged_in
    def index
       render "index"
    end

    def create
        menu=Menu.new(
            menu_name: params[:menu_name],
            menu_cost: params[:menu_cost],
            menu_description: params[:menu_description],
         )
         #session[:current_user_id]= user.id
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
end