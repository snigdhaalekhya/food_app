class Cart < ActiveRecord::Base
    # validates :menu_name, presence: true
    # validates :menu_description, presence: true
    # validates :menu_cost, presence: true

     #has_secure_password
    # has_many :todos
    belongs_to :user
    def self.of_user(user)
        all.where(user_id: user.id)
    end
end