ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# class ActiveSupport::TestCase
#   # Run tests in parallel with specified workers
#   parallelize(workers: :number_of_processors)

#   # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
#   fixtures :all

#   # Add more helper methods to be used by all tests here...
# end
class ActiveSupport::TestCase
  fixtures :all
  def setup
    @routes = Rails.application.routes
  end

  def teardown
    
  end
end

# class ActionController::TestCase
#     if RUBY_VERSION>='2.6.0'
#         if Rails.version < ''
#           class ActionController::TestResponse < ActionDispatch::TestResponse
#             def recycle!
#               # hack to avoid MonitorMixin double-initialize error:
#               @mon_mutex_owner_object_id = nil
#               @mon_mutex = nil
#               initialize
#             end
#           end
#         else
#           puts "Monkeypatch for ActionController::TestResponse no longer needed"
#         end
#       end
#     def setup
#         debugger
#         @routes = Rails.application.routes
#       end
    
#       def teardown
        
#       end
# class ActionController::TestResponse < ActionDispatch::TestResponse
#     def recycle!
#       # hack to avoid MonitorMixin double-initialize error:
#       @mon_mutex_owner_object_id = nil
#       @mon_mutex = nil
#       initialize
#     end
#   end
# else
#   puts "Monkeypatch for ActionController::TestResponse no longer needed"
# end
end
