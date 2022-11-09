require_relative '../test_helper'
class SessionsResControllerTest < ActiveSupport::TestCase

  def setup
    super
    before_all
  end

  def before_all
    Owner.all.destroy_all
    @owner = FactoryGirl.create(:owner)
    Worker.all.destroy_all
    @worker = FactoryGirl.create(:worker)
  end

  def test_signin_creation_success_owner
    value = pass_params("Owner", @owner.email, @owner.password)
    response = post "/signin_restaurant", value
    assert_equal(response.status, 302)
    assert_equal(Owner.last.email, value[:email])
  end

  def test_signin_creation_success_worker
    value = pass_params("Worker", @worker.email, @worker.password)
    response = post "/signin_restaurant", value
    assert_equal(response.status, 302)
    assert_equal(Worker.last.email, value[:email])
  end

  def test_signin_creation_notsuccess
    value = pass_params("", @worker.email, @worker.password)
    response = post "/signin_restaurant", value
    assert_equal(response.status, 302)
  end

  def test_signin_creation_notsuccess1
    value = pass_params("Worker", @worker.email, Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password)
    response = post "/signin_restaurant", value
    assert_not_equal(@worker.password, value[:password])
    assert_equal(response.status, 302)
  end

  def test_signin_creation_notsuccess2
    value = pass_params("Worker", @owner.email, @worker.password)
    response = post "/signin_restaurant", value
    assert_not_equal(@worker.email, value[:email])
    assert_equal(response.status, 302)
  end

  def test_signin_creation_notsuccess3
    value = pass_params("Worker", @owner.email, Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password)
    response = post "/signin_restaurant", value
    assert_not_equal(@worker.email, value[:email])
    assert_equal(response.status, 302)
  end

  def test_signin_creation_notsuccess4
    value = pass_params("Owner", @owner.email, Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password)
    response = post "/signin_restaurant", value
    assert_not_equal(@owner.password, value[:password])
    assert_equal(response.status, 302)
  end

  def test_signin_creation_notsuccess5
    value = pass_params("Owner", @worker.email, @owner.password)
    response = post "/signin_restaurant", value
    assert_not_equal(@owner.email, value[:email])
    assert_equal(response.status, 302)
  end

  def test_signin_creation_notsuccess6
    value = pass_params("Owner", @worker.email, Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password)
    response = post "/signin_restaurant", value
    assert_not_equal(@owner.email, value[:email])
    assert_not_equal(@owner.password, value[:password])
    assert_equal(response.status, 302)
  end

  def test_password_checkparams_notsuccess
    value = pass_params("", @worker.email, @worker.password)
    response = post "/signin_restaurant/update_password", value
    assert_equal(response.status, 302)
  end

  def test_password_notexistuser
    value = pass_params("Owner", Faker::Internet.email, @worker.password)
    response = post "/signin_restaurant/update_password", value
    assert_equal(response.status, 302)
  end

  def test_password_equal_notblank
    value = pass_params_for_updatepassword("Owner", @owner.email, Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password, Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password)
    response = post "/signin_restaurant/update_password", value
    assert_equal(response.status, 302)
  end

  def test_password_equal_blank
    value = pass_params_for_updatepassword("Owner", @owner.email, "", "")
    response = post "/signin_restaurant/update_password", value
    assert_equal(response.status, 302)
  end

  def test_password_notequal
    value = pass_params_for_updatepassword("Owner", @owner.email, @worker.password, "")
    response = post "/signin_restaurant/update_password", value
    assert_equal(response.status, 302)
  end

  def test_session_destroy
    response = delete "/signout_restaurant"
    assert_equal(response.status, 302)
  end

  private
  def pass_params(identity, email, password)
    value = {identity: identity, email: email, password: password}
  end

  def pass_params_for_updatepassword(identity, email, password, password_confirm)
    value = {identity: identity, email: email, password: password, password_confirm: password_confirm}
  end

end
