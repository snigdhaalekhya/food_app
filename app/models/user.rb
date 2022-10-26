class User < ApplicationRecord
  include CommonValidation
     validates :mobile_no, presence: true, numericality: true,  length: { is: 10 }
    #  has_many :carts
    paginates_per 10

end
# MVC - 
# MODEL  - DATABASE RELATED ACTIVITY
# VIEW - RESPONSE SHOULD LOOK LIKE
# Controller - REQUEST ACTION
# VALIDATIONS - REQUEST VALIDATION SHOULD TAKE PLACE