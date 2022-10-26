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
    post "/workers", value
    puts "success"
  end

  def test_worker_email_check
    field_value = {email: @worker.email }
    post "/users", field_value 
    puts "This email is already registered. Please retry."
    # assert_redirected_to new_user_path
  end

  def test_worker_mobileno_check
    field_value = {mobile_no: @worker.mobile_no }
    post "/users", field_value 
    puts "This mobile no is already registered. Please retry."
    # assert_redirected_to new_user_path
  end
end
