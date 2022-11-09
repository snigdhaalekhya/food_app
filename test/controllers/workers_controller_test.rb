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
    value = pass_params(Faker::Name.name[1..18], Faker::Number.number(digits: 10), Faker::Internet.email, @worker.password , Faker::Lorem.paragraph)
    response = post "/workers", value
    assert_equal(Worker.last.name, value[:name])
    assert_equal(response.status,302)
  end

  def test_worker_create_notsuccess_without_tendigit_mobileno
    value = pass_params(Faker::Name.name[1..18], Faker::Number.number(digits: 5), Faker::Internet.email, @worker.password , Faker::Lorem.paragraph)
    response = post "/workers", value
    assert_not_equal(Faker::Number.number[10], value[:mobile_no])
    assert_equal(response.status,302)
  end

  def test_worker_createnotsuccess_withoutemail
    value = pass_params(Faker::Name.name[1..18],Faker::Number.number(digits: 10), "", @worker.password , Faker::Lorem.paragraph)
    response = post "/workers", value
    assert_not_equal(Faker::Internet.email, value[:email])
    assert_equal(response.status,302)
  end

  def test_worker_createnotsuccess_without_notfollowed_passwordrules
    value = pass_params(Faker::Name.name[1..18], Faker::Number.number(digits: 10), Faker::Internet.email, Faker::Internet.password , Faker::Lorem.paragraph)
    response = post "/workers", value
    assert_equal(response.status,302)
  end
  
  def test_worker_createnotsuccess_without_allrequiredfields
    value = pass_params("", "", "", "", "")
    response = post "/workers", value
    assert_not_equal(Faker::Name.name, value[:name])
    assert_not_equal(Faker::Number.number(digits: 10), value[:mobile_no])
    assert_not_equal(Faker::Internet.email, value[:email])
    assert_not_equal(@worker.password, value[:password])
    assert_not_equal(Faker::Lorem.paragraph, value[:address])
    assert_equal(response.status, 302)
  end

  def test_worker_email_check_present_in_db
    field_value = {email: @worker.email }
    response = post "/workers", field_value 
    assert_equal(Worker.last.email , field_value[:email])
    assert_equal(response.status, 302)
  end

  def test_worker_mobileno_check_present_in_db
    field_value = {mobile_no: @worker.mobile_no }
    response = post "/workers", field_value 
    assert_equal(Worker.last.mobile_no , field_value[:mobile_no])
    assert_equal(response.status, 302)
  end

  private
  def pass_params(name, mobile_no, email, password, address)
    value = {name: name, mobile_no: mobile_no, email: email, password: password, address: address}
  end

end
