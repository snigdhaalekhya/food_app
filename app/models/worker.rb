class Worker < ApplicationRecord

PASSWORD_REQUIREMENTS = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[A-Z])        # Must contain an upper case character
  (?=.*[[:^alnum:]]) # Must contain a symbol
/x
    validates :name, presence: true
    validates :mobile_no, presence: true, numericality: true,  length: { is: 10 }
    validates :email, presence: true
    validates :address, presence: true
    validates :password, presence: true, format: PASSWORD_REQUIREMENTS
    
     has_secure_password
    
  # after_save    :cachemethod
  # after_destroy :expire_all_cache

  def self.cachemethod
    Rails.cache.fetch(Worker.all) {all.to_a}
  end

  def self.expire_all_cache
     Rails.cache.delete('Worker.all')
  end
end