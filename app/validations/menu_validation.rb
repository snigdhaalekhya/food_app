module MenuValidation
  extend ActiveSupport::Concern
  included do
    MENU_NAME = /\A
       ^[a-zA-Z  ]*$
    /x 
     validates :menu_name, presence: true, length: {maximum: 18}, format: MENU_NAME
     validates :menu_category, presence: true
     validates :menu_description, presence: true
     validates :menu_cost, presence: true
     validates :menu_image, presence: true
  end
    
end
