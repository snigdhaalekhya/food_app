module MainHelper

    def currentuser_records(model)
         model.where(user_id: current_user.id)
    end

    def currentuser_records_in_reverse_order(model)
      currentuser_records(model).sort_by(&:updated_at).reverse
    end

    def status_type(status)
        currentuser_records(Order).select{ |s| s.status == status }
    end

    def cart_notempty
        Cart.find_by(user_id: current_user)
    end

    def menu_details
        menu = ""
        currentuser_records(Cart).each do |cart|
            menu_id = cart.menu_id
            menu_name = Menu.find(cart.menu_id).menu_name
            count = cart.count
            cost = cart.count * Menu.find(cart.menu_id).menu_cost
            menu = menu+menu_name + "*" + count.to_s + "*" + cost.to_s + "+"
        end
        menu.chop
    end

    def users_active_orders
        currentuser_records(Order).where.not(status: AllConstants::ACTIVE_ORDERS)
    end

    def users_completed_orders
       currentuser_records(Order).where(status: AllConstants::COMPLETED_ORDERS)
    end

    def total_cart_count
        cart_totalcount = 0
        currentuser_records(Cart).each do |cart|
            cart_totalcount = cart_totalcount + cart.count
        end
        return cart_totalcount
    end

    def total_cost(params)
     total_cost = 0
      params.menu.split("+") do |o|
        str = o.split("*")
        total_cost = str[2].to_i + total_cost
      end
      return total_cost.to_s
    end

    def status_not_delivered
        Order.where(status: AllConstants::NOT_DELIVERED)
    end
end
