class SessionRes < ApplicationRecord
PASSWORD_REQUIREMENTS = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x
    validates :email, presence: true
    validates :password, presence: true, format: PASSWORD_REQUIREMENTS
    validates :identity, presence: true

     has_secure_password
    # has_many :todos
end