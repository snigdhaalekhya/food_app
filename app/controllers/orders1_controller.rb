class Orders1Controller < ApplicationController 
    skip_before_action :ensure_user_logged_in
    # def index
    #      @orders= Order.of_user(current_user)
    #      @orders=@orders.sort_by(&:updated_at).reverse
    #      @user=current_user
    #      @cost=0
    # end
    def create
    end

    def show
        id= params[:id]
        order_id=Order.find(id)
        # @orders_queue= Order.where.not(status: "Delivered")
        order_id.status=params[:status]
        order_id.save!
        redirect_to orders_restaurant_path
    end
     
     def all_orders
     end

     def completed_orders
        @orders_completed=Order.where(status: "Delivered")
     end
end