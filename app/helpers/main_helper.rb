module MainHelper
    MENU_ROOT = "/menus"

    def currentuser_model(model)
      model.of_user(current_user)
    end 

    def currentuser_model_reverse(model)
      currentuser_model(model).sort_by(&:updated_at).reverse
    end

    def method_status(status)
        currentuser_model(Order).select{|s| s.status == status }
    end 

    def method_status_not(status)
        currentuser_model(Order).select{|s| s.status != status }
    end

    def cart_notempty
        Cart.find_by(user_id: current_user)
    end

    def menu_details
        menu = ""
        currentuser_model(Cart).each do |cart|
            menu_id = cart.menu_id 
            menu_name = Menu.find(cart.menu_id).menu_name
            count = cart.count
            cost = cart.count*Menu.find(cart.menu_id).menu_cost 
            menu = menu+menu_name+"*"+count.to_s+"*"+cost.to_s+"+"
        end
        menu.chop
    end

    def method_active_orders
        currentuser_model(Order).where.not(status: ["Delivered", "Confirm Success","Cancelled"])           
    end

    def method_completed_orders
        currentuser_model(Order).where(status: ["Delivered", "Confirm Success"])
    end

end 