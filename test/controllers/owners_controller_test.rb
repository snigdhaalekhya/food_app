require_relative '../test_helper'
class OwnersControllerTest < ActiveSupport::TestCase
  include ActionDispatch::Assertions
  def setup
    super
    Owner.all.destroy_all
    @owner = FactoryGirl.create(:owner)
  end

  def test_owner_creation
     value = pass_params(Faker::Name.name[1..18], Faker::Internet.email, @owner.password, Faker::Lorem.paragraph)
     response =  post "/owners", value
     assert_equal(Owner.last.email, value[:email])
     assert_equal(response.status, 302)
  end

  def test_owner_creation_notsuccess_withoutemail
    value = pass_params(Faker::Name.name[1..18], "", @owner.password, Faker::Lorem.paragraph)
    response = post  "/owners", value
    assert_not_equal(Faker::Internet.email, value[:email])
    assert_equal(response.status, 302)
  end

  def test_owner_creation_notsuccess_without_notfollowed_passwordrules
    value = pass_params(Faker::Name.name[1..18], Faker::Internet.email, Faker::Internet.password , Faker::Lorem.paragraph)
    assert_not_equal(@owner.password, value[:password])
    response = post  "/owners", value
    assert_equal(response.status, 302)
  end

  def test_owner_creation_notsuccess_without_allrequiredfields
    value = pass_params("", "", "", "")
    response = post  "/owners", value
    assert_not_equal(Faker::Name.name, value[:name])
    assert_not_equal(Faker::Internet.email, value[:email])
    assert_not_equal(@owner.password, value[:password])
    assert_not_equal(Faker::Lorem.paragraph, value[:address])
    assert_equal(response.status, 302)
  end

  def test_owner_email_check_present_in_db
    value = { email: @owner.email }
    response = post "/owners", value
    assert_equal(Owner.last.email , value[:email])
    assert_equal(response.status, 302)
  end

  private
  def pass_params(name, email, password, address)
    value = { name: name, email: email, password: password, address: address }
  end
end
