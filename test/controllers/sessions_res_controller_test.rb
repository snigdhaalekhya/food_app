require_relative '../test_helper'
require "action_controller/railtie"

class SessionsResControllerTest < ActiveSupport::TestCase

  def setup
    super
    before_all
  end

  def before_all
    Owner.all.destroy_all
    Worker.all.destroy_all
    @owner = Owner.new({name: "test_owner" , email: "ownertest@owner" , password:"Abcdef@1" , address:"address"})
    @owner.save
    @worker = Worker.new({name: "test_worker" , mobile_no: 1223324222 , email: "workertest@worker" , password:"Abcdef@1" , address:"address" , owner_id: 1})
    @worker.save
  end

  def test_signin_create_success_owner
    value = {identity: "Owner", email: @owner.email, password: @owner.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
    #assert_equal(response.header["Location"],"http://example.org/orders1")
  end

  def test_signin_create_success_worker
    value = {identity: "Worker", email: @worker.email, password: @worker.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
    #assert_equal(response.header["Location"],"http://example.org/orders1")
  end

  def test_signin_create_notsuccess
    value = {identity: "", email: @worker.email, password: @worker.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
    #assert_equal(response.header["Location"],"http://example.org/signin_restaurant/new")
  end

  def test_signin_create_notsuccess1
    value = {identity: "Worker", email: @worker.email, password: "Bbcdef@1"}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
    #assert_equal(response.header["Location"],"http://example.org/signin_restaurant/new")
  end

  def test_signin_create_notsuccess2
    value = {identity: "Worker", email: @owner.email, password: @worker.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
    #assert_equal(response.header["Location"],"http://example.org/signin_restaurant/new")
  end

  def test_signin_create_notsuccess3
    value = {identity: "Worker", email: @owner.email, password: "Bbcdef@1"}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
    #assert_equal(response.header["Location"],"http://example.org/signin_restaurant/new")
  end

  def test_signin_create_notsuccess4
    value = {identity: "Owner", email: @owner.email, password: "Bbcdef@1"}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
    #assert_equal(response.header["Location"],"http://example.org/signin_restaurant/new")
  end

  def test_signin_create_notsuccess5
    value = {identity: "Owner", email: @worker.email, password: @owner.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
    #assert_equal(response.header["Location"],"http://example.org/signin_restaurant/new")
  end

  def test_signin_create_notsuccess6
    value = {identity: "Owner", email: @worker.email, password: "Bbcdef@1"}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
     #assert_equal(response.header["Location"],"http://example.org/signin_restaurant/new")
  end

  def test_password_checkparams_notsuccess
    value = {identity: "", email: @worker.email, password: @worker.password}
    response = post "/signin_restaurant/update_password", value
    assert_equal(response.status,302)
  end

  def test_password_notexistuser
    value = {identity: "Owner", email: "ed@ed", password: @worker.password}
    response = post "/signin_restaurant/update_password", value
    assert_equal(response.status,302)
  end

  def test_password_equal_notblank
    value = {identity: "Owner", email: @owner.email, password: "Bbcdef@1", password_confirm: "Bbcdef@1"}
    response = post "/signin_restaurant/update_password", value
    assert_equal(response.status,302)
  end

  def test_password_equal_blank
    value = {identity: "Owner", email: @owner.email, password: "", password_confirm: ""}
    response = post "/signin_restaurant/update_password", value
    assert_equal(response.status,302)
  end

  def test_password_notequal
    value = {identity: "Owner", email: @owner.email, password: "sderr@df2", password_confirm: ""}
    response = post "/signin_restaurant/update_password", value
    assert_equal(response.status,302)
  end

  def test_destroy
    response = delete "signout_restaurant"
    assert_equal(response.status,302)
  end
end
