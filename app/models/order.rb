class Order < ApplicationRecord
    belongs_to :user
    def self.of_user(user)
        all.where(user_id: user.id)
    end

    # after_save    :expire_all_cache
    # after_destroy :expire_all_cache
   
    def self.call
      cachemethod()
      expire_all_cache()
    end 
    def self.orders1cache
      Rails.cache.fetch("") {Order.where.not(status: "Delivered").and (Order.where.not(status: "Cancelled"))}
    end 
    def self.orders1cachecompleted
      Rails.cache.fetch("") {Order.where(status: "Delivered")}
    end
    # def self.orders1cachename
    #   Rails.cache.fetch("") do
    #     Order.all.each do |order|
    #     return User.find(order.user_id).name.to_a
    #      return order
    #     end
    #   end
    # end
    
end