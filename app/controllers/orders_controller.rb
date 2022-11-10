class OrdersController < ApplicationController
	include MainHelper
	 
	def create
		order = Order.new(user_id: current_user.id, menu: menu_details, status: AllConstants::PENDING, owner_id: AllConstants::ID_OR_COUNT)
			if order.save
				NotifierMailer.with(order: order).send_mail_to_owner.deliver_now
				NotifierMailer.with(order: order).send_mail_to_user_for_status_update.deliver_now
				redirect_to orders_path
				currentuser_records(Cart).each do |cart|
					cart.destroy
				end
			end
	end
	
	def update
		update_status(AllConstants::CONFIRM_SUCCESS)
	end

	def updateto_not_delivered
		update_status(AllConstants::NOT_DELIVERED)		    
	end

	private
	def update_status(status)
		order_id = Order.find(params[:id])
		order_id.status = status
		if order_id.save
			redirect_to main_index_path        
		end
	end
end
