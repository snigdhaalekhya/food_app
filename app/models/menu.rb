class Menu < ApplicationRecord
    include MenuValidation

    def self.search(search)
        where(["menu_name LIKE?","%#{search}%"]).uniq
    end
    
end
