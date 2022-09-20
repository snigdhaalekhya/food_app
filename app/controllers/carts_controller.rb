class CartsController < ApplicationController 
    #skip_before_action :ensure_user_logged_in
    # skip_before_action :ensure_owner_logged_in

    def index
        @carts= Cart.of_user(current_user)
        @carts_notempty=Cart.find_by(user_id: current_user)
        @user=current_user
        @cost=0;
        @c=1;
    end

    def create
        
    end
    
    def show
       id= params[:id]
       menu=Menu.find(id)
       cart_menuid=Cart.of_user(current_user).find_by(menu_id: menu.id)
        if cart_menuid == nil 
             cart=Cart.new(
             user_id: current_user.id,
             menu_id: menu.id,
             count: 1
            )
            if cart.save
                redirect_to view_user_path
             end
        else
            cart=Cart.of_user(current_user).find_by(menu_id: menu.id) 
            cart.count=cart.count+1
            # render plain: cart.count
            cart.save!
            redirect_to view_user_path
        end
     end

    def remove
        id= params[:id]
        menu=Menu.find(id)
        cart_menuid=Cart.of_user(current_user).find_by(menu_id: menu.id)
        if cart_menuid.count >= 1
            cart_menuid.count=cart_menuid.count-1
            cart_menuid.save!
            redirect_to view_user_path 
        end
        if cart_menuid.count == 0
            cart_menuid.destroy 
         end 
    end
    #  public def initialize
    #  @cost=0;
    #  @c=1;
    #  end
end