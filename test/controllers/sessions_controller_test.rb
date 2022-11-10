require_relative '../test_helper'
class SessionsControllerTest < ActiveSupport::TestCase

  def setup
    super
    User.all.destroy_all
    @user = FactoryGirl.create(:user)
  end

  def test_with_no_mobileno_present_in_db 
    value = pass_params(Faker::Number.number[10], @user.password)
    response = post "/signin_users", value
    assert_not_equal(@user.mobile_no, value[:mobile_no])
    assert_equal(response.status, 302)
  end

  def test_checkparams_nomobile_no
    value = pass_params("", @user.password)
    response = post "/signin_users", value
    assert_equal(response.status, 302)
  end

  def test_checkparams_nopassword
    value = pass_params(@user.mobile_no, "")
    response = post "/signin_users", value
    assert_equal(response.status, 302)
  end

  def test_signin_create_success
    value = pass_params(@user.mobile_no, @user.password)
    response = post "/signin_users", value
    assert_equal(User.last.mobile_no, value[:mobile_no])
    assert_equal(response.status, 302)
  end

  def test_signin_create_notsuccess
    value = pass_params(@user.mobile_no, Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true) + Faker::Internet.password)
    response = post "/signin_users", value
    assert_not_equal(@user.password, value[:password])
    assert_equal(response.status, 302)
  end
  
  def test_password_checkparams_no_mobileno
    field_value = pass_params_for_updatepassword( "", @user.password, @user.password)
    field_value = { mobile_no: "", password: @user.password , password_confirm: @user.password }
    response = post "/signin_users/update_password", field_value
    assert_equal(response.status, 302)
  end

  def test_password_checkparams_no_newpassword
    field_value = pass_params_for_updatepassword(@user.mobile_no,  "", @user.password)
    response = post "/signin_users/update_password", field_value
    assert_equal(response.status, 302)
  end

  def test_password_checkparams_no_confirmpassword
    field_value = pass_params_for_updatepassword(@user.mobile_no, @user.password, "")
    response = post "/signin_users/update_password", field_value
    assert_equal(response.status, 302)
  end

  def test_password_doesnotmatch
    field_value = pass_params_for_updatepassword(@user.mobile_no, @user.password, Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true) + Faker::Internet.password)
    response = post "/signin_users/update_password", field_value
    assert_equal(response.status, 302)
  end

  def test_password_success
    field_value = pass_params_for_updatepassword(@user.mobile_no, Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true) + Faker::Internet.password, Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true) + Faker::Internet.password)
    response = post "/signin_users/update_password", field_value
    assert_equal(response.status, 302)
  end
  
  def test_session_destroy
    response = delete "/signout_users"
    assert_equal(response.status, 302)
  end

  private
  def pass_params(mobile_no, password)
    value = { mobile_no: mobile_no, password: password }
  end

  def pass_params_for_updatepassword(mobile_no, password, password_confirm)
    value = { mobile_no: mobile_no, password: password, password_confirm: password_confirm }
  end
end
