class NotifierMailer < ApplicationMailer
    # If order is placed owner receives mail with order,customer details
    def send_mail_order
     order = params[:order]
     @order_id=order.id
     @order=order.user_id
     @user_name=User.find(@order).name
     @user_mobileno=User.find(@order).mobile_no
     @user_address=User.find(@order).address
     @menu= order.menu
     @owner=order.owner_id
     @owner_mail=Owner.find(@owner).email
     mail(from: "ammualekhya6@gmail.com",to: @owner_mail, subject: "New order placed by #{@user_name}")
    end

    #If order status is updated send mail to customer
    def send_mail_status
    order = params[:order]
     @order_id=order.id
     @order=order.user_id
     @user_name=User.find(@order).name
     @user_mobileno=User.find(@order).mobile_no
     @user_address=User.find(@order).address
     @user_mail=User.find(@order).email
     @menu= order.menu
     @owner=order.owner_id
     @owner_name=Owner.find(@owner).name
     @status=order.status
     @owner_mail=Owner.find(@owner).email
     mail(from: "ammualekhya6@gmail.com",to: @user_mail, subject: "Status for the Order ##{@order_id} placed from restaurant")
    end
end
