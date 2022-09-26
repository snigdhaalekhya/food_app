class Menu < ApplicationRecord
    validates :menu_name, presence: true
    validates :menu_category, presence: true
    validates :menu_description, presence: true
    validates :menu_cost, presence: true
    validates :menu_image, presence: true

     #has_secure_password
    # has_many :todos
    #  belongs_to :owner
    # def self.of_user(owner)
    #     all.where(owner_id: owner.id)
    # end
    def self.search(search)
        where(["menu_name LIKE?","%#{search}%"]).uniq
    end

end