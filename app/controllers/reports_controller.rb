class ReportsController < ApplicationController 
    skip_before_action :ensure_user_logged_in
    before_action :ensure_owner_logged_in
    
    def index
        # @name=params[:name]
        # @customer_id=User.find_by(name: name)
        # @customer_orders=Order.where(user_id: @customer_id.id.to_s).to_a
        # @customer_order=Order.find_by(user_id: User.find_by(name: name).id)
    end
    def customer_orders_view
        @name=params[:name]
        # @customer_id=User.find_by(name: name)
        # @customer_orders=Order.where(user_id: @customer_id.id.to_s).to_a
         # render plain: @customer_orders
        #  redirect_to reports_customer_orders_view_path
    end

    # def customer_orders
    #     @name=params[:name]
    # end
end