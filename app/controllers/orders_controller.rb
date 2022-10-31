class OrdersController < ApplicationController 
    include MainHelper
   
    def create
        order = Order.new(user_id:current_user.id , menu:menu_details , status:AllConstants::PENDING , owner_id:AllConstants::VALUE )
            if order.save
                 # If order is placed owner receives mail with order,customer details
                 NotifierMailer.with(order: order).send_mail_order.deliver_now
                 NotifierMailer.with(order: order).send_mail_status.deliver_now
                 redirect_to orders_path
                 currentuser_model(Cart).each do |cart|
                    cart.destroy
                end
            end     
    end
  
   
     def update
        order_id = Order.find(params[:id])
        order_id.status = "Confirm Success"
        if order_id.save
            redirect_to main_index_path
        end
     end 
end