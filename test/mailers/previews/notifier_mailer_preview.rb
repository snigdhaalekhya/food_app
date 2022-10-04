# Preview all emails at http://localhost:3000/rails/mailers/notifier_mailer
class NotifierMailerPreview < ActionMailer::Preview

  # If order is placed owner receives mail with order,customer details
   def send_mail_order
       NotifierMailer.with(order: Order.last).send_mail_order
   end

   #If order status is updated send mail to customer
   def send_mail_status
    NotifierMailer.with(order: Order.order('updated_at desc').first).send_mail_status
   end

end
