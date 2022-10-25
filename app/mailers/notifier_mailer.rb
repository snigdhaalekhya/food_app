class NotifierMailer < ApplicationMailer
    # If order is placed owner receives mail with order,customer details
    def send_mail_order
     common
      mail(from: "ammualekhya6@gmail.com",to: @owner_mail, subject: "New order placed by #{@user_name}",
        body: "New order placed by the customer with Order Id: #{ @order_id}\nCustomer name: #{@user_name}\nCustomer Mobile number: #{@user_mobileno}\nCustomer Address: #{@user_address}\nItems placed order: #{menu_items}\nTotal cost: #{total_cost}")
    end

    #If order status is updated send mail to customer
    def send_mail_status
      common
      mail(from: "ammualekhya6@gmail.com",to: @user_mail, subject: "Status for the Order ##{@order_id} placed from restaurant",
        body: "Order status for  Order Id: #{ @order_id}\nCustomer name: #{@user_name}\nCustomer Mobile number: #{@user_mobileno}\nCustomer Address: #{@user_address}\nOrder status Update: #{@status}\n#{menu_items}\nTotal cost: #{total_cost}")
    end


    
    def common
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

    def menu_items
       @cost = 0 
       order_details = ""
       @menu.split("+") do |o| 
         str= o.split("*")
         @cost = @cost + str[2].to_i
         order_details = order_details+"#{str[0]}  X #{str[1]} = #{str[2]} ₹\n"
       end 
         return  order_details
    end

    def total_cost
        return @cost.to_s + " ₹"
    end
end
