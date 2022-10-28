require_relative '../test_helper'
require "action_controller/railtie"

class UsersControllerTest < ActiveSupport::TestCase
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
    response = post "/users", field_value
    #assert_equal(response.header["Location"],"http://example.org/main")
    assert_equal(response.status,302)
  end

  def test_user_create_notsuccess_without_tendigit_mobileno
    field_value  = { name: "name" , mobile_no: 1234567 , email: "email1@email1" , password:"Abcdef@1" , address:"address"}
    response = post "/users", field_value
    assert_equal(response.status,302)
  end

  def test_user_create_notsuccess_withoutemail
    field_value  = { name: "name" , mobile_no: 1234567890 , email: "" , password:"Abcdef@1" , address:"address"}
    response = post "/users", field_value
    assert_equal(response.status,302)
  end

  def test_user_create_notsuccess_without_notfollowed_passwordrules
    field_value  = { name: "name" , mobile_no: 1234567890 , email: "email1@email1" , password:"Abcdefghi" , address:"address"}
    response = post "/users", field_value
    assert_equal(response.status,302)
  end

  def test_user_create_notsuccess_without_allrequiredfields
    field_value  = { name: "" , mobile_no: "" , email: "" , password:"" , address:""}
    response = post "/users", field_value
    assert_equal(response.status,302)
  end

  def test_user_mobileno_check
   field_value = {mobile_no: @user.mobile_no }
   response = post "/users", field_value
   #assert_equal(response.header["Location"],"http://example.org/users/new")
   assert_equal(response.status,302)
  end

  def test_user_email_check
    field_value = {email: @user.email }
    response = post "/users", field_value 
    #assert_equal(response.header["Location"],"http://example.org/users/new")
    assert_equal(response.status,302)
  end
end
