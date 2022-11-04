require_relative '../test_helper'

class UsersControllerTest < ActiveSupport::TestCase
  def setup
    super
     User.all.destroy_all
     @user = FactoryGirl.create(:user)
  end

  def test_user_creation
    field_value  = { name: Faker::Name.name[1..18] , mobile_no: Faker::Number.number(digits: 10) , email: Faker::Internet.email , password:@user.password , address:Faker::Lorem.paragraph}
    response = post "/users", field_value
    assert_equal(User.last.email, field_value[:email])
    assert_equal(response.status,302)
  end

  def test_user_creation_notsuccess_without_tendigit_mobileno
    field_value  = { name: Faker::Name.name[1..18] , mobile_no: 1234567 , email: Faker::Internet.email , password:@user.password , address:Faker::Lorem.paragraph}
    response = post "/users", field_value
    assert_equal(response.status,302)
  end

  def test_user_creation_notsuccess_withoutemail
    field_value  = { name:Faker::Name.name[1..18] , mobile_no: Faker::Number.number(digits: 10) , email: "" , password:@user.password , address:Faker::Lorem.paragraph}
    response = post "/users", field_value
    assert_equal(response.status,302)
  end

  def test_user_creation_notsuccess_without_notfollowed_passwordrules
    field_value  = { name: Faker::Name.name[1..18] , mobile_no: Faker::Number.number(digits: 10), email: Faker::Internet.email , password:"Abcdefghi" , address:Faker::Lorem.paragraph}
    response = post "/users", field_value
    assert_equal(response.status,302)
  end

  def test_user_creation_notsuccess_without_allrequiredfields
    field_value  = { name: "" , mobile_no: "" , email: "" , password:"" , address:""}
    response = post "/users", field_value
    assert_equal(response.status,302)
  end

  def test_user_mobileno_check_present_in_db
   field_value = {mobile_no: @user.mobile_no }
   response = post "/users", field_value
   assert_equal(response.status,302)
  end

  def test_user_email_check_present_in_db
    field_value = {email: @user.email }
    response = post "/users", field_value 
    assert_equal(response.status,302)
  end
end
