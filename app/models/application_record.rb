  class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
        def self.cachemethod
             Rails.cache.fetch('model') {all.to_a}
        end


        def self.expire_all_cache
              Rails.cache.delete('parameter')
        end
      
        def self.cache(model)
            Rails.cache.fetch('model') {all.to_a}
        end  
end
