class User < ApplicationRecord
PASSWORD_REQUIREMENTS = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
  /x
    validates :name, presence: true, length: {maximum: 18}
    validates :mobile_no, presence: true, numericality: true,  length: { is: 10 }
    validates :email, presence: true
    validates :address, presence: true
    validates :password, presence: true, format: PASSWORD_REQUIREMENTS

     has_secure_password
     has_many :carts

    def self.user_create(name,mobile_no,email,password,address)
      user = User.new(
      name: name,
      mobile_no: mobile_no,
      email: email,
      password: password,
      address: address,
   )
  end
  
end
