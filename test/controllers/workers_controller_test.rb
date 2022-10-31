require_relative '../test_helper'

class WorkersControllerTest < ActiveSupport::TestCase

  def setup
    super
    Owner.all.destroy_all
    @owner = FactoryGirl.create(:owner)
    Worker.all.destroy_all
    @worker = FactoryGirl.create(:worker)
    value = {identity: "Owner", email: @owner.email , password:@owner.password }
    post  "/signin_restaurant" , value
  end

  def test_worker_create
    value = {name:  Faker::Name.name[1..18], mobile_no: Faker::Number.number(digits: 10), email:Faker::Internet.email, password: "Abcdef@1", address:Faker::Lorem.paragraph}
    response = post "/workers", value
    assert_equal(Worker.last.name, value[:name])
    assert_equal(response.status,302)
  end

  def test_worker_create_notsuccess_without_tendigit_mobileno
    value = {name:  Faker::Name.name[1..18], mobile_no: 1234567, email:Faker::Internet.email, password: "Abcdef@1", address:Faker::Lorem.paragraph}
    response = post "/workers", value
    assert_equal(response.status,302)
  end

  def test_worker_createnotsuccess_withoutemail
    value = {name:  Faker::Name.name[1..18], mobile_no: Faker::Number.number(digits: 10), email:"", password: "Abcdef@1", address:Faker::Lorem.paragraph}
    response = post "/workers", value
    assert_equal(response.status,302)
  end

  def test_worker_createnotsuccess_without_notfollowed_passwordrules
    value = {name:  Faker::Name.name[1..18], mobile_no:Faker::Number.number(digits: 10), email:Faker::Internet.email, password: "Abcdef", address:Faker::Lorem.paragraph}
    response = post "/workers", value
    assert_equal(response.status,302)
  end
  
  def test_worker_createnotsuccess_without_allrequiredfields
    value = {name: "", mobile_no:"" , email:"", password: "", address:""}
    response = post "/workers", value
    assert_equal(response.status,302)
  end

  def test_worker_email_check_present_in_db
    field_value = {email: @worker.email }
    response = post "/workers", field_value 
    assert_equal(response.status,302)
  end

  def test_worker_mobileno_check_present_in_db
    field_value = {mobile_no: @worker.mobile_no }
    response = post "/workers", field_value 
    assert_equal(response.status,302)
  end
end
