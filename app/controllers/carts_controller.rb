class CartsController < ApplicationController 
 include MainHelper


    def index      
    end
    
    def show
     if Menu.find_by(id: params[:id]).present?
       menu = Menu.find(params[:id])
       cart_menuid = model_user(Cart).find_by(menu_id: menu.id)
        if cart_menuid.present?
            cart = Cart.of_user(current_user).find_by(menu_id: menu.id) 
            cart.count = cart.count + 1
        else
            cart = Cart.cart_create(current_user.id, menu.id,1)
        end
        if cart.save!
            redirect_to view_user_path
        end   
     end
    end

    def remove
        if Menu.find_by(id: params[:id]).present?
        menu = Menu.find(params[:id])
        cart_menuid = Cart.of_user(current_user).find_by(menu_id: menu.id)
          if cart_menuid.present?
           if cart_menuid.count >= 1
            cart_menuid.count = cart_menuid.count - 1
            cart_menuid.save!
            redirect_to view_user_path 
           end
           if cart_menuid.count == 0
            cart_menuid.destroy 
           end 
          else
            redirect_to view_user_path
          end
      end
    end
end