class Owner < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true
    validates :address, presence: true
    validates :password, presence: true

     has_secure_password
    # has_many :todos
end