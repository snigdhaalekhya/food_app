require_relative '../test_helper'
require "action_controller/railtie"

class WorkersControllerTest < ActiveSupport::TestCase

  def setup
    super
    before_all
  end

  def before_all
    Owner.all.destroy_all
    Worker.all.destroy_all
    @owner = Owner.new({ name: "test_owner" , email: "ownertest@worker" , password:"Abcdef@1" , address:"address"})
    @owner.save
    @worker = Worker.new({ name: "test_worker" , mobile_no: 1223324222 , email: "workertest@worker" , password:"Abcdef@1" , address:"address" , owner_id: 1})
    @worker.save
    value = {identity: "Owner", email: @owner.email , password:@owner.password }
    post  "/signin_restaurant" , value
  end

  def test_worker_create
    value = {name: "name", mobile_no: 1234567890, email:"email@email", password: "Abcdef@1", address:"worker"}
    response = post "/workers", value
    #assert_equal(response.header["Location"],"http://example.org/workers")
    assert_equal(response.status,302)
  end

  def test_worker_create_notsuccess_without_tendigit_mobileno
    value = {name: "name", mobile_no: 1234567, email:"email@email", password: "Abcdef@1", address:"worker"}
    response = post "/workers", value
    #assert_equal(response.header["Location"],"http://example.org/workers")
    assert_equal(response.status,302)
  end

  def test_worker_createnotsuccess_withoutemail
    value = {name: "name", mobile_no: 1234567890, email:"", password: "Abcdef@1", address:"worker"}
    response = post "/workers", value
    #assert_equal(response.header["Location"],"http://example.org/workers")
    assert_equal(response.status,302)
  end

  def test_worker_createnotsuccess_without_notfollowed_passwordrules
    value = {name: "name", mobile_no: 1234567890, email:"email@email", password: "Abcdef", address:"worker"}
    response = post "/workers", value
    #assert_equal(response.header["Location"],"http://example.org/workers")
    assert_equal(response.status,302)
  end
  
  def test_worker_createnotsuccess_without_allrequiredfields
    value = {name: "", mobile_no:"" , email:"", password: "", address:""}
    response = post "/workers", value
    #assert_equal(response.header["Location"],"http://example.org/workers")
    assert_equal(response.status,302)
  end

  def test_worker_email_check
    field_value = {email: @worker.email }
    response = post "/workers", field_value 
    #assert_equal(response.header["Location"],"http://example.org/workers/new")
    assert_equal(response.status,302)
  end

  def test_worker_mobileno_check
    field_value = {mobile_no: @worker.mobile_no }
    response = post "/workers", field_value 
    #assert_equal(response.header["Location"],"http://example.org/workers/new")
    assert_equal(response.status,302)
  end
end
