require_relative '../test_helper'
require "action_controller/railtie"
require "rack/test"
class UsersControllerTest < ActiveSupport::TestCase


  def test_user_create
    debugger
    post "/users"
     #post "/users", params: { user: { name: "name" , mobile_no: "1234567891" , email: "email@email" , password:"Abcdef@1" , address:"address"} }
     assert_response :success
  end

  def test_user_mobileno_check
    # get user.mobile_no
    User.stubs(:mobile_no).returns("This mobile number is already registered. Please retry.")
    post "/users", user: {mobile_no: "1234567891"}
    assert_equal flash[:error], "This mobile number is already registered. Please retry."
  end

  #   new_user = User.new
  #   post :create, params:{name: "name"}
  #   assert_response 200
  #   # assert_includes @post.title, @response.body
  #   post :create, :user => { name: new_user.name, email: test_email  }
  #   assert_equal ture, true
  # end
end
# require "minitest/autorun"
#require "action_controller/railtie"
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