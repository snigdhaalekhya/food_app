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
    value = {identity: "Owner", email: @owner.email, password: @owner.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
    assert_equal(Owner.last.email,value[:email])
  end

  def test_signin_creation_success_worker
    value = {identity: "Worker", email: @worker.email, password: @worker.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
    assert_equal(Worker.last.email,value[:email])
  end

  def test_signin_creation_notsuccess
    value = {identity: "", email: @worker.email, password: @worker.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
  end

  def test_signin_creation_notsuccess1
    value = {identity: "Worker", email: @worker.email, password: Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
  end

  def test_signin_creation_notsuccess2
    value = {identity: "Worker", email: @owner.email, password: @worker.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
  end

  def test_signin_creation_notsuccess3
    value = {identity: "Worker", email: @owner.email, password: Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
  end

  def test_signin_creation_notsuccess4
    value = {identity: "Owner", email: @owner.email, password: Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
  end

  def test_signin_creation_notsuccess5
    value = {identity: "Owner", email: @worker.email, password: @owner.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
  end

  def test_signin_creation_notsuccess6
    value = {identity: "Owner", email: @worker.email, password: Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password}
    response = post "/signin_restaurant", value
    assert_equal(response.status,302)
  end

  def test_password_checkparams_notsuccess
    value = {identity: "", email: @worker.email, password: @worker.password}
    response = post "/signin_restaurant/update_password", value
    assert_equal(response.status,302)
  end

  def test_password_notexistuser
    value = {identity: "Owner", email:Faker::Internet.email, password: @worker.password}
    response = post "/signin_restaurant/update_password", value
    assert_equal(response.status,302)
  end

  def test_password_equal_notblank
    value = {identity: "Owner", email: @owner.email, password: Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password, password_confirm:Faker::Internet.password(min_length: 8,  mix_case: true, special_characters: true)+ Faker::Internet.password}
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

  def test_session_destroy
    response = delete "/signout_restaurant"
    assert_equal(response.status,302)
  end
end
