require_relative '../test_helper'
require "action_controller/railtie"

class UsersControllerTest < ActiveSupport::TestCase

  # def test_newuser
  #   get "/users/new"
  #   debugger
  #   assert_response :success
  # end
  def setup
    super
    before_all
  end

  def before_all
    User.all.destroy_all
    @user = User.new({id: 1, name: "test" , mobile_no: 1223324222 , email: "email@email" , password:"Abcdef@1" , address:"address"})
    @user.save
  end

  def test_user_create
    field_value  = { name: "name" , mobile_no: 1234567890 , email: "email1@email1" , password:"Abcdef@1" , address:"address"}
    post "/users", field_value
    # assert_redirected_to new_user_path
    # assert_equal User.first.name, field_value[:name]
    #  assert_response 200
  end

  def test_user_mobileno_check
   field_value = {mobile_no: @user.mobile_no }
  # debugger
   post "/users", field_value
   debugger
   assert_redirected_to new_user_path
  # puts flash[:error]

  # flash[:sa] = "kxn"
  # puts flash[:sa]
  
  # puts flash["error"]
  # debugger
    # assert_equal "This mobile number is already registered. Please retry.", "This mobile number is already registered. Please retry."

  #  assert_equal User.first.mobile_no, 
    # post "/users", user: {mobile_no: "1234567891"}
    # assert_equal "This mobile number is a
    # lready registered. Please retry.", flash[:error]
  end

  def test_user_email_check
    field_value = {email: @user.email }
    post "/users", field_value 
    assert_redirected_to new_user_path
  end
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