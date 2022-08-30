class Session < ApplicationRecord
    validates :mobile_no, presence: true
    validates :password, presence: true

     has_secure_password
    # has_many :todos
end