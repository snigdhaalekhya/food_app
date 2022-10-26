class Cart < ApplicationRecord
    paginates_per 10
    # belongs_to :user

    def self.of_user(current_user)
        all.where(user_id: current_user.id)
    end

end
