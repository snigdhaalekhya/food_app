class Orders1Controller < ApplicationController 
    skip_before_action :ensure_user_logged_in
    before_action :ensure_owner_logged_in 

    def index
        if Owner.find_by(email: current_owner.email)
            @owner_worker= current_owner.email
        elsif Worker.find_by(email: current_owner.email)
            @owner_worker= current_owner.email
        end
    end


    def update
        id= params[:id]
        order_id=Order.find(id)
        order_id.status=params[:status]
        if order_id.save!
           NotifierMailer.with(order: order_id).send_mail_status.deliver_later
            redirect_to orders_restaurant_path
        end
    end
     
     def all_orders
     end

     def completed_orders
        @orders_completed=Order.where(status: "Delivered")
     end
end