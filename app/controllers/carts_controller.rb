class CartsController < ApplicationController 
  before_action :find_menuid, only: [:show, :remove]
  include MainHelper


    def index      
    end
    
    def show
       cart_menuid = find_cartmenuid
        if cart_menuid.present?
            cart = find_cartmenuid 
            cart.count = cart.count + 1
        else
            cart = Cart.cart_create(current_user.id , find_menuid.id , VALUE)
        end
        if cart.save
            redirect_to main_index_path
        end   
    end

    def remove
        cart_menuid = find_cartmenuid
          if cart_menuid.present?
           if cart_menuid.count >= 1
            cart_menuid.count = cart_menuid.count - 1
            if cart_menuid.count == 0
              cart_menuid.destroy 
             end 
            cart_menuid.save
           end
            redirect_to main_index_path
          end
      end

      private
      def find_menuid
        menu = Menu.find(params[:id])
      end

      def find_cartmenuid
        currentuser_model(Cart).find_by(menu_id: find_menuid.id)
      end
end