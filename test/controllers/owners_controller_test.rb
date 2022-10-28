require_relative '../test_helper'
require "action_controller/railtie"

class OwnersControllerTest < ActiveSupport::TestCase
 include ActionDispatch::Assertions
  def setup
    super
    before_all
  end

  def before_all
    Owner.all.destroy_all
    @owner = Owner.new({ name: "test_owner" , email: "ownertest@worker" , password:"Abcdef@1" , address:"address"})
    @owner.save
  end

  def test_owner_create
     value = {name: "name", email:"email@email", password: "Abcdef@1", address:"address"}
     response =  post "/owners", value
     #assert_equal(response.header["Location"],"http://example.org/orders1")
     assert_equal(response.status,302)
  end

  def test_owner_create_notsuccess_withoutemail
    value  = { name: "name" , email: "" , password:"Abcdef@1" , address:"address"}
    response = post  "/owners", value
    assert_equal(response.status,302)
  end

  def test_owner_create_notsuccess_without_notfollowed_passwordrules
    value  = { name: "name" ,email: "email1@email1" , password:"Abcdefghi" , address:"address"}
    response = post  "/owners", value
    assert_equal(response.status,302)
  end

  def test_owner_create_notsuccess_without_allrequiredfields
    value  = { name: "" ,  email: "" , password:"" , address:""}
    response = post  "/owners", value
    assert_equal(response.status,302)
  end

  def test_owner_email_check
    value = {email: @owner.email }
    response = post "/owners", value 
    #assert_equal(response.header["Location"],"http://example.org/owners/new")
    assert_equal(response.status,302)
  end

end
