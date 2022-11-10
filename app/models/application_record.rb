  class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
        def self.cachemethod
             Rails.cache.fetch('model') {all.to_a}
        end
        
        def self.cache(model)
            Rails.cache.fetch('model') {model.to_a}
        end

        def self.cache_modelrecords(model)
            Rails.cache.fetch('model') {model}
       end
end
