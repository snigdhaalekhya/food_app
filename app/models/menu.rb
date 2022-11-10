class Menu < ApplicationRecord
    include MenuValidation

    def self.search(search)
        all.where(["menu_name LIKE?","%#{search}%"])
    end
end
