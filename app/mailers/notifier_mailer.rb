class NotifierMailer < ApplicationMailer
    # If order is placed owner receives mail with order,customer all_details
    def send_mail_order
      construct_email_params
      mail(from: "ammualekhya6@gmail.com",to: @owner_mail, subject: "New order placed by #{@user_name}",
        body: "New order placed by the customer with Order Id: #{ @order_id}\nCustomer name: #{@user_name}\nCustomer Mobile number: #{@user_mobileno}\nCustomer Address: #{@user_address}\nItems placed order: #{menu_items}\nTotal cost: #{total_cost}")
    end

    #If order status is updated send mail to customer
    def send_mail_status
      construct_email_params
      mail(from: "ammualekhya6@gmail.com",to: @user_mail, subject: "Status for the Order ##{@order_id} placed from restaurant",
        body: "Order status for  Order Id: #{ @order_id}\nCustomer name: #{@user_name}\nCustomer Mobile number: #{@user_mobileno}\nCustomer Address: #{@user_address}\nOrder status Update: #{@status}\n#{menu_items}\nTotal cost: #{total_cost}")
    end

    #If order has not been delivered successfully
    def send_mail_notsuccess
      construct_email_params
      mail(from: @owner_mail,to: @user_mail, subject: "Status for the Order ##{@order_id} placed from restaurant",
        body: "#{params[:reason]}")
    end


    private
    def construct_email_params
     order = params[:order]
     @order_id = order.id
     @order=order.user_id
     @user_name=User.find(@order).name
     @user_mobileno=User.find(@order).mobile_no
     @user_address=User.find(@order).address
     @user_mail=User.find(@order).email
     @menu= order.menu
     @owner=order.owner_id
     @status=order.status
     @owner_name=Owner.find(@owner).name
     @owner_mail=Owner.find(@owner).email
    end

    private
    def menu_items
       @cost = 0 
       order_all_details = ""
       @menu.split("+") do |o| 
         str= o.split("*")
         @cost = @cost + str[2].to_i
         order_all_details = order_all_details + "#{str[0]} "+ AllConstants::QUANTITY + " #{str[1]} " + AllConstants::ASSIGN + " #{str[2]} " + AllConstants::COST + "\n"
       end 
         return  order_all_details
    end

    private
    def total_cost
        return @cost.to_s + AllConstants::COST
    end

end

