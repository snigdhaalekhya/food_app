class OrdersController < ApplicationController 
    include MainHelper
    
    def index
    end
    def create
        order = Order.order_create(current_user.id,method_menu,"Pending",1)
            if order.save
                 redirect_to orders_path
                 # If order is placed owner receives mail with order,customer details
                 NotifierMailer.with(order: order).send_mail_order.deliver_later
                 NotifierMailer.with(order: order).send_mail_status.deliver_later
                 model_user(Cart).each do |cart|
                    cart.destroy
                end
            end
    end
  
    def active_orders
    end

     def completed_orders
     end

     def update
        order_id = Order.find(params[:id])
        order_id.status="Confirm Success"
        if order_id.save!
            redirect_to view_user_path
        end
     end 
end