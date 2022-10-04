class CartsController < ApplicationController 
 include MainHelper


    def index      
    end

    def create      
    end
    
    def show
       menu=Menu.find(params[:id])
       cart_menuid=model_user(Cart).find_by(menu_id: menu.id)
        if cart_menuid == nil 
            cart = Cart.cart_create(current_user.id, menu.id,1)
            if cart.save
                redirect_to view_user_path
             end
        else
            cart=Cart.of_user(current_user).find_by(menu_id: menu.id) 
            cart.count=cart.count+1
            cart.save!
            redirect_to view_user_path
        end
     end

    def remove
        menu=Menu.find(params[:id])
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
end