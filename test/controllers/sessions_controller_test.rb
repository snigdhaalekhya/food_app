require_relative '../test_helper'

class SessionsControllerTest < ActiveSupport::TestCase

  def setup
    super
    User.all.destroy_all
    @user = FactoryGirl.create(:user)
  end

  def test_with_no_mobileno_present_in_db 
    value = {mobile_no: 3456789012, password: @user.password}
    response = post "/signin_users", value
    assert_equal(response.status,302)
  end

  def test_checkparams_nomobile_no
    value = {mobile_no: "", password: @user.password}
    response = post "/signin_users", value
    assert_equal(response.status,302)
  end

  def test_checkparams_nopassword
    value = {mobile_no:@user.mobile_no , password: ""}
    response = post "/signin_users", value
    assert_equal(response.status,302)
  end

  def test_signin_create_success
    value = {mobile_no: @user.mobile_no, password: @user.password}
    response = post "/signin_users", value
    assert_equal(User.last.mobile_no, value[:mobile_no])
    assert_equal(response.status,302)
  end

  def test_signin_create_notsuccess
    value = {mobile_no: @user.mobile_no, password:"Bbcdef@1"}
    response = post "/signin_users", value
    assert_equal(response.status,302)
  end

  
  def test_password_checkparams_no_mobileno
    field_value = {mobile_no:"", password:@user.password , password_confirm: @user.password}
    response = post "/signin_users/update_password", field_value
    assert_equal(response.status,302)
  end

  def test_password_checkparams_no_newpassword
    field_value = {mobile_no: @user.mobile_no, password:"" , password_confirm: @user.password}
    response = post "/signin_users/update_password", field_value
    assert_equal(response.status,302)
  end

  def test_password_checkparams_no_confirmpassword
    field_value = {mobile_no: @user.mobile_no, password:@user.password , password_confirm:""}
    response = post "/signin_users/update_password", field_value
    assert_equal(response.status,302)
  end

  def test_password_doesnotmatch 
    field_value = { mobile_no: @user.mobile_no, password: @user.password, password_confirm:Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password }
    response = post "/signin_users/update_password", field_value
    assert_equal(response.status,302)
  end

  def test_password_success
    field_value = { mobile_no: @user.mobile_no, password: "Bbcdef@1", password_confirm:Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password }
    response = post "/signin_users/update_password", field_value
    assert_equal(response.status,302)
  end
  
  def test_session_destroy
    response = delete "/signout_users"
    assert_equal(response.status,302)
  end
end