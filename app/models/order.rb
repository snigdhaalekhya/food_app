class Order < ApplicationRecord
    belongs_to :user
    def self.of_user(user)
        all.where(user_id: user.id)
    end
    
    def self.order_create(id,menu,status,owner_id)
        order = Order.new(
        user_id: id,
        menu: menu,
        status: status,
        owner_id: owner_id,
       )
    end
   
    def self.orders1cache
      Rails.cache.fetch("") {Order.where.not(status: ["Delivered","Cancelled","Confirm Success"])}
    end
    def self.orders1cachecompleted
      Rails.cache.fetch("") {Order.where(status: "Delivered")}
    end
end