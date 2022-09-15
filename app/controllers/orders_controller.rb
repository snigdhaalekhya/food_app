class OrdersController < ApplicationController 
    #skip_before_action :ensure_user_logged_in
    # skip_before_action :ensure_owner_logged_in
    def index
         @orders= Order.of_user(current_user)
         @orders=@orders.sort_by(&:updated_at).reverse
         @user=current_user
         @cost=0
    end
    def create
        @user=current_user
        @carts=Cart.of_user(current_user)
        @cost=0
        @menu=""
        @carts.each do |cart|
            @menu_id=cart.menu_id 
            @menu_name=Menu.find(cart.menu_id).menu_name
            @count=cart.count
            @cost=cart.count*Menu.find(cart.menu_id).menu_cost 
            @menu= @menu+@menu_name+"*"+@count.to_s+"*"+@cost.to_s+"+"
        end
        @menu=@menu.chop
        order=Order.new(
              user_id: current_user.id,
              menu: @menu,
              status: "Pending",
             )
            if order.save
                 redirect_to orders_path
                @carts.each do |cart|
                    cart.destroy
                    # redirect_to orders_path
                end
            end
    end
  
    def active_orders
        @orders= Order.of_user(current_user)
       #  @orders=@orders.sort_by(&:updated_at).reverse
       #  render plain: @orders.to_a.join("\n")
        @user=current_user
        @cost=0
       @orders_active=@orders.where.not(status: "Delivered").and(@orders.where.not(status: "Cancelled"))
       @orders_active=@orders_active.sort_by(&:updated_at).reverse
    end

    def completed_orders
         @orders= Order.of_user(current_user)
        #  @orders=@orders.sort_by(&:updated_at).reverse
        #  render plain: @orders.to_a.join("\n")
         @user=current_user
         @cost=0
        @orders_completed=@orders.where(status: "Delivered")
        @orders_completed=@orders_completed.sort_by(&:updated_at).reverse
     end
end