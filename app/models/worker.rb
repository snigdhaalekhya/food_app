class Worker < ApplicationRecord
    validates :name, presence: true
    validates :mobile_no, presence: true
    validates :email, presence: true
    validates :address, presence: true
    validates :password, presence: true
    
     has_secure_password
    # has_many :todos
end