class Order < ApplicationRecord
    paginates_per 10
    # belongs_to :user
    def self.of_user(current_user)
        all.where(user_id: current_user.id)
    end
  
    def self.orders1cache
      Rails.cache.fetch("") {Order.where.not(status: AllConstants::ACTIVE_ORDERS)}
    end
    
    def self.orders1cachecompleted
      Rails.cache.fetch("") {Order.where(status: AllConstants::DELIVERED)}
    end

end