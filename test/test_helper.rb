ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "rack/test"
Dir["#{Rails.root}/app/**/*.rb"].each {|x| require x}

# require 'capybara/poltergeist'
# require "minitest/rails/capybara"
# require 'simplecov'
# SimpleCov.start 'rails'
# require 'minitest/autorun'
# Dir["../lib/**/*.rb"].each do |rb_file|
#   require rb_file
# end
class ActiveSupport::TestCase
  include Rack::Test::Methods
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def app
    Rails.application
  end

  # Add more helper methods to be used by all tests here...
end
# class ActiveSupport::TestCase
#   fixtures :all
#   def setup
#     @routes = Rails.application.routes
#   end

#   def teardown
    
#   end
# end

# class ActionController::TestCase
   
# end
