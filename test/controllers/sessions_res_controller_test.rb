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
    post "/signin_restaurant", value
    puts "success_owner"
  end

  def test_signin_create_success_worker
    value = {identity: "Worker", email: @worker.email, password: @worker.password}
    post "/signin_restaurant", value
    puts "success_worker"
  end

  def test_signin_create_notsuccess
    value = {identity: "", email: @worker.email, password: @worker.password}
    post "/signin_restaurant", value
    puts "Select login type from given radio options"
  end

  def test_signin_create_notsuccess1
    value = {identity: "Worker", email: @worker.email, password: "Bbcdef@1"}
    post "/signin_restaurant", value
    puts "Your login attempt was invalid. Please retry."
  end

  def test_signin_create_notsuccess2
    value = {identity: "Worker", email: @owner.email, password: @worker.password}
    post "/signin_restaurant", value
    puts "Your login attempt was invalid. Please retry."
  end

  def test_signin_create_notsuccess3
    value = {identity: "Worker", email: @owner.email, password: "Bbcdef@1"}
    post "/signin_restaurant", value
    puts "Your login attempt was invalid. Please retry."
  end

  def test_signin_create_notsuccess4
    value = {identity: "Owner", email: @owner.email, password: "Bbcdef@1"}
    post "/signin_restaurant", value
    puts "Your login attempt was invalid. Please retry."
  end

  def test_signin_create_notsuccess5
    value = {identity: "Owner", email: @worker.email, password: @owner.password}
    post "/signin_restaurant", value
    puts "Your login attempt was invalid. Please retry."
  end

  def test_signin_create_notsuccess6
    value = {identity: "Owner", email: @worker.email, password: "Bbcdef@1"}
    post "/signin_restaurant", value
    puts "Your login attempt was invalid. Please retry."
  end

end
