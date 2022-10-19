class Cart < ApplicationRecord
    belongs_to :user, touch: true

    def self.of_user(user)
        all.where(user_id: user.id)
    end
  
    def self.cart_create(id , menu_id , count)
      cart = Cart.new(
        user_id: id,
        menu_id: menu_id,
        count: count
       )
    end
end