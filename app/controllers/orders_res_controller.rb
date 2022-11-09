class OrdersResController < ApplicationController 
    skip_before_action :ensure_user_logged_in
    before_action :ensure_owner_logged_in

    def update
        order_id = find_by_id
        order_id.status = params[:status]
        if order_id.save
           NotifierMailer.with(order: order_id).send_mail_to_user_for_status_update.deliver_now
           redirect_to orders1_index_path
        end
    end

    def send_mail
        order_id = find_by_id
        if !params[:reason].blank?
           NotifierMailer.with(order: order_id, reason: params[:reason]).send_mail_to_user_with_apology_message.deliver_now
           order_id.update(status: AllConstants::REMOVE)
        end
           redirect_to orders1_index_path
    end

    private
    def find_by_id
        Order.find(params[:id])
    end
    
end
