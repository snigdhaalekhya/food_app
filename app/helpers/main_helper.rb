module MainHelper

    def model_user(model)
      model.of_user(current_user)
    end 

    def model_user_reverse(model)
      model_user(model).sort_by(&:updated_at).reverse
    end

    def method_status(stat)
        model_user(Order).select{|s| s.status == stat }
    end 

    def method_status_not(stat)
        model_user(Order).select{|s| s.status != stat }
    end

    def cart_notempty
        Cart.find_by(user_id: current_user)
    end

    def method_menu
        menu=""
        model_user(Cart).each do |cart|
            menu_id=cart.menu_id 
            menu_name=Menu.find(cart.menu_id).menu_name
            count=cart.count
            cost=cart.count*Menu.find(cart.menu_id).menu_cost 
            menu= menu+menu_name+"*"+count.to_s+"*"+cost.to_s+"+"
        end
        menu.chop
    end

    def method_active_orders
         orders_active = model_user(Order).where.not(status: ["Delivered", "Confirm Success","Cancelled"])    
    end

    def method_completed_orders
        orders_completed = model_user(Order).where(status: ["Delivered", "Confirm Success"])
    end

end 