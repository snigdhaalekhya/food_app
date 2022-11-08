require_relative '../test_helper'

class UsersControllerTest < ActiveSupport::TestCase
  def setup
    super
     User.all.destroy_all
     @user = FactoryGirl.create(:user)
  end

  def test_user_creation
    field_value = pass_params(Faker::Name.name[1..18], Faker::Number.number(digits: 10), Faker::Internet.email, @user.password , Faker::Lorem.paragraph)
    response = post "/users", field_value
    assert_equal(User.last.email, field_value[:email])
    assert_equal(response.status,302)
  end

  def test_user_creation_notsuccess_without_tendigit_mobileno
    field_value = pass_params(Faker::Name.name[1..18], Faker::Number.number(digits: 5), Faker::Internet.email, @user.password , Faker::Lorem.paragraph)
    response = post "/users", field_value
    assert_not_equal(Faker::Number.number(digits: 10), field_value[:mobile_no])
    assert_equal(response.status,302)
  end

  def test_user_creation_notsuccess_withoutemail
    field_value = pass_params(Faker::Name.name[1..18],Faker::Number.number(digits: 10), "", @user.password , Faker::Lorem.paragraph)
    response = post "/users", field_value
    assert_not_equal(Faker::Internet.email, field_value[:email])
    assert_equal(response.status,302)
  end

  def test_user_creation_notsuccess_without_notfollowed_passwordrules
    field_value = pass_params(Faker::Name.name[1..18], Faker::Number.number(digits: 10), Faker::Internet.email, Faker::Internet.password , Faker::Lorem.paragraph)
    response = post "/users", field_value
    assert_equal(response.status,302)
  end

  def test_user_creation_notsuccess_without_allrequiredfields
    value = pass_params("", "", "", "", "")
    assert_not_equal(Faker::Name.name, value[:name])
    assert_not_equal(Faker::Number.number[10], value[:mobile_no])
    assert_not_equal(Faker::Internet.email, value[:email])
    assert_not_equal(@user.password, value[:password])
    assert_not_equal(Faker::Lorem.paragraph, value[:address])
    response = post "/users", value
    assert_equal(response.status,302)
  end

  def test_user_mobileno_check_present_in_db
   field_value = {mobile_no: @user.mobile_no }
   response = post "/users", field_value
   assert_equal(User.last.mobile_no , field_value[:mobile_no])
   assert_equal(response.status,302)
  end

  def test_user_email_check_present_in_db
    field_value = {email: @user.email }
    response = post "/users", field_value 
    assert_equal(User.last.email , field_value[:email])
    assert_equal(response.status,302)
  end

  private
  def pass_params(name, mobile_no, email, password, address)
    value = {name: name, mobile_no: mobile_no, email: email, password: password, address: address}
  end

end

