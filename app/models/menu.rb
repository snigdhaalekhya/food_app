class Menu < ApplicationRecord
  # gem 'active_storage_validations'
  # require 'active_storage_validations'
  # #  include ActiveStorageValidations
  # include ActiveModel::Model
  # include ActiveStorage
  include ActiveStorageValidations
    validates :menu_name, presence: true
    validates :menu_category, presence: true
    validates :menu_description, presence: true
    validates :menu_cost, presence: true
    validates :menu_image, presence: true
    # has_one_attached :image 
    # validates :image, presence:true

    def self.search(search)
        where(["menu_name LIKE?","%#{search}%"]).uniq
    end

    def self.menu_create(menu_name,menu_category,menu_cost, menu_description,menu_image)
      menu=Menu.new(
        menu_name: menu_name,
        menu_category:menu_category,
        menu_cost: menu_cost,
        menu_description: menu_description,
        menu_image: menu_image
      )
    end 
end