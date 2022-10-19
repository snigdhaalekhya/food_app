class OrdersResController < ApplicationController 
    skip_before_action :ensure_user_logged_in
    before_action :ensure_owner_logged_in 

    def index
    end


    def update
        order_id = Order.find(params[:id])
        order_id.status = params[:status]
        if order_id.save
           NotifierMailer.with(order: order_id).send_mail_status.deliver_now
            redirect_to orders1_index_path
        end
    end
     
     def all_orders
     end

     def completed_orders
     end
end