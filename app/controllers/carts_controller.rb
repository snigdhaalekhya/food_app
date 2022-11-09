class CartsController < ApplicationController 
  include MainHelper

    def show
       cart_menuid = find_cartmenuid
        if cart_menuid.present?
            cart_menuid.count = cart_menuid.count + 1
        else
            cart_menuid = Cart.new(user_id: current_user.id, menu_id: find_menuid.id, count: AllConstants::ID_OR_COUNT, owner_id: AllConstants::ID_OR_COUNT)
        end
        if cart_menuid.save
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
      end	   
      redirect_to main_index_path  
    end

    private
    def find_menuid
      Menu.find(params[:id])
    end

    def find_cartmenuid
       currentuser_records(Cart).find_by(menu_id: find_menuid.id)
    end

end
