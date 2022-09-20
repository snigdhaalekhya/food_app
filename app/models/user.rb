class User < ApplicationRecord
    validates :name, presence: true
    validates :mobile_no, length: { is: 10 },presence: true
    validates :email, presence: true
    validates :address, presence: true
    validates :password, presence: true

     has_secure_password
     has_many :carts
end