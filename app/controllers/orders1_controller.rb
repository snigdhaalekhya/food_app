class Orders1Controller < ApplicationController 
    skip_before_action :ensure_user_logged_in
    before_action :ensure_owner_logged_in 
        # if Owner.find_by(email: current_owner_id)
        #     @current_owner= Owner.find_by(email: current_owner_id)
        # elsif Worker.find_by(email: current_owner_id)
        #     @current_worker= Worker.find_by(email: current_owner_id)
        # end
    # before_action :ensure_worker_logged_in
    def index
        # render plain: current_owner.email
        if Owner.find_by(email: current_owner.email)
            @owner_worker= current_owner.email
        elsif Worker.find_by(email: current_owner.email)
            @owner_worker= current_owner.email
        end
    #      @orders= Order.of_user(current_user)
    #      @orders=@orders.sort_by(&:updated_at).reverse
    #      @user=current_user
    #      @cost=0
    end
    def create
    end

    def show
        # if Owner.find_by(email: current_owner.email)
        #     @current_owner= current_owner.email
        #     render plain: @current_owner
        # elsif Worker.find_by(email: current_owner.email)
        #     @current_worker= current_owner.email
        # end
        id= params[:id]
        order_id=Order.find(id)
        # @orders_queue= Order.where.not(status: "Delivered")
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