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
        menu=Menu.new(post_params)
          #   menu_name: params[:menu_name],
          #   menu_category: params[:menu_category],
          #   menu_cost: params[:menu_cost],
          #   menu_description: params[:menu_description],
          #   # menu_image: params[:image]
          # )

           if menu.save
              redirect_to "/menu_restaurant" 
       
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
      if Owner.find_by(email: current_owner.email)
        @owner_worker= current_owner.email
      elsif Worker.find_by(email: current_owner.email)
        @owner_worker= current_owner.email
      end  
      @category=params[:menu_category]
      @menus_category= Menu.where(menu_category: params[:menu_category])
    end 



    def edit
      id=params[:id]
      @menu_edit=Menu.find(id)
    end

    def update
      id=params[:id]
      @menu=Menu.find(id)
      @menu.update(menu_name: params[:menu][:menu_name], menu_description: params[:menu][:menu_description], menu_category: params[:menu][:menu_category], menu_cost: params[:menu][:menu_cost], menu_image: params[:menu][:image] )
      redirect_to "/menu_restaurant"
    end


    def destroy
        id = params[:id]
        menu_delete=Menu.find(id)
        menu_delete.destroy
        redirect_to "/menu_restaurant"
        # render plain: "deleted"
    end
    
  private
    def post_params
      params.require(:post).permit(:menu_name, :menu_description, :menu_cost, :menu_category,:image)
    end
end