class Session < ApplicationRecord
PASSWORD_REQUIREMENTS = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
  /x
    validates :mobile_no, presence: true, numericality: true,  length: { is: 10 }
    validates :password, presence: true, format: PASSWORD_REQUIREMENTS

     has_secure_password
    # has_many :todos
end