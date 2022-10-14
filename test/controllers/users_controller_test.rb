#  require_relative '../test_helper'
# require "minitest/autorun"
# require "action_controller"

# class TestUser < ActionController::TestCase
#     def test_create
#         post :create, {} 
#     end
# end
require 'minitest/autorun'
require "action_controller"
# include User
class UsersController_Test < ActionController::TestCase
  def setup
    @post = User.new(name: 'Hello World')
   
  end
  def test_create
    post :create
    assert_response 200
    # assert_includes @post.title, @response.body
  end
end