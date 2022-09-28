class Owner < ApplicationRecord
PASSWORD_REQUIREMENTS = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x
    validates :name, presence: true
    validates :email, presence: true
    validates :address, presence: true
    validates :password, presence: true, format: PASSWORD_REQUIREMENTS

     has_secure_password
     has_many :menus
    # has_many :todos
    # after_save    :expire_all_cache
    # after_destroy :expire_all_cache
   
    def self.call
      cachemethod()
      expire_all_cache()
    end 
end