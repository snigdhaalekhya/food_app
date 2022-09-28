class Cart < ApplicationRecord
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
end