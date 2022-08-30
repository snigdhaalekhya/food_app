class Menu < ApplicationRecord
    validates :menu_name, presence: true
    validates :menu_description, presence: true
    validates :menu_cost, presence: true

     #has_secure_password
    # has_many :todos
end