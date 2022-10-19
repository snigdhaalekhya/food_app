#  require_relative '../test_helper'
# require "minitest/autorun"
# require "action_controller"
# require "test_helper"
# class TestUser < ActionController::TestCase
# food_app/app/test_helper.rbb
# include User
#     def test_create
#         post :create, {} 
#     end
# end
# require 'test_helper'
require 'minitest/spec'
require 'minitest/autorun'
# require 'script'
# require "action_controller/railtie"
# require "active_support"
class UsersControllerTest <  ActionController::TestCase
    include UsersController

  def setup
    debugger
    puts 'create'
  end
end
# require "minitest/autorun"
# require "action_controller/railtie"
# require "active_support"
# class UsersControllerTest <  ActionController::TestCase
#     include UsersController

#   def setup
#     debugger
#     @new_user = User.new(name: 'Hello World')
#     @new_user.save
#   end
#   def test_create
#     debugger
#     abc = User.first
#     post :create, params:{name: "name"}
#     assert_response 200
#     # assert_includes @post.title, @response.body
#   end
# end