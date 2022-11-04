module MainHelper

    def currentuser_model(model)
         model.where(user_id: current_user.id)
    end 

    def currentuser_model_reverse_order(model)
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
            cost = cart.count * Menu.find(cart.menu_id).menu_cost 
            menu = menu+menu_name + "*" + count.to_s + "*" + cost.to_s + "+"
        end
        menu.chop
    end

    def users_active_orders
        currentuser_model(Order).where.not(status: AllConstants::ACTIVE_ORDERS )           
    end

    def users_completed_orders
       currentuser_model(Order).where(status: AllConstants::COMPLETED_ORDERS)
    end

    def total_cart_count
        cart_totalcount = 0
        currentuser_model(Cart).each do |cart|
            cart_totalcount = cart_totalcount + cart.count
        end
        return cart_totalcount
    end

    def total_cost(parameter)
     total_cost = 0
      parameter.menu.split("+") do |o|
        str = o.split("*")
        total_cost = str[2].to_i + total_cost
      end
      return total_cost.to_s
    end

    def status_not_delivered
        Order.where(status: "Not Delivered")
    end
end 


    