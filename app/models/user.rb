class User < ApplicationRecord
  include CommonValidation
     validates :mobile_no, presence: true, numericality: true,  length: { is: 10 }
     has_many :carts

end
