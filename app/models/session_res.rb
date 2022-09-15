class SessionRes < ApplicationRecord
    validates :email, presence: true
    validates :password, presence: true
    validates :identity, presence: true

     has_secure_password
    # has_many :todos
end