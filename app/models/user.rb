class User < ApplicationRecord
    validates :name, presence: true
    validates :mobile_no, presence: true
    validates :address, presence: true
    validates :password, presence: true

     has_secure_password
     has_many :carts
end