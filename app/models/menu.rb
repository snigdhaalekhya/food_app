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

    # after_save    :expire_all_cache
    # after_destroy :expire_all_cache
   
    def self.cachemethod
      Rails.cache.fetch('Menu.all') {all.to_a}
    end


 def self.expire_all_cache
       Rails.cache.delete('Menu.all')
 end
end