class Session < ApplicationRecord
    validates :mobile_no, length: { is: 10 },presence: true
    validates :password, presence: true

     has_secure_password
    # has_many :todos
end