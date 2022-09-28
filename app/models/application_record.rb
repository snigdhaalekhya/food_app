  class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
        def self.cachemethod
             Rails.cache.fetch('parameter') {all.to_a}
        end


        def self.expire_all_cache
              Rails.cache.delete('parameter')
        end
    
end
