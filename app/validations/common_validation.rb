module CommonValidation
    extend ActiveSupport::Concern
    included do
        PASSWORD_REQUIREMENTS = /\A
        (?=.{8,})          # Must contain 8 or more characters
        (?=.*\d)           # Must contain a digit
        (?=.*[A-Z])        # Must contain an upper case character
        (?=.*[[:^alnum:]]) # Must contain a symbol
      /x
        validates :name, presence: true, length: {maximum: 18}
        validates :email, presence: true
        validates :address, presence: true
        validates :password, presence: true, format: CommonValidation::PASSWORD_REQUIREMENTS
    
         has_secure_password
    end
      
  end