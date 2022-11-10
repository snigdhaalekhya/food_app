ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "rack/test"
require "action_controller/railtie"
require 'faker'
require 'rubocop-faker'

Dir["#{Rails.root}/app/**/*.rb"].each {|x| require x}

class ActiveSupport::TestCase
  include Rack::Test::Methods
  include FactoryGirl::Syntax::Methods
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def app
    Rails.application
  end
end
