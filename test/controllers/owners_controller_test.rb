require_relative '../test_helper'

class OwnersControllerTest < ActiveSupport::TestCase
 include ActionDispatch::Assertions
  def setup
    super
    Owner.all.destroy_all
    @owner = FactoryGirl.create(:owner)
  end


  def test_owner_creation
     value = {name: Faker::Name.name[1..18], email:Faker::Internet.email, password: @owner.password, address:Faker::Lorem.paragraph}
     response =  post "/owners", value
     assert_equal(Owner.last.email, value[:email])
     assert_equal(response.status,302)
  end

  def test_owner_creation_notsuccess_withoutemail
    value  = { name:Faker::Name.name[1..18] , email: "" , password:@owner.password , address:Faker::Lorem.paragraph}
    response = post  "/owners", value
    assert_equal(response.status,302)
  end

  def test_owner_creation_notsuccess_without_notfollowed_passwordrules
    value  = { name: Faker::Name.name[1..18],email: Faker::Internet.email , password:"Abcdefghi" , address:Faker::Lorem.paragraph}
    response = post  "/owners", value
    assert_equal(response.status,302)
  end

  def test_owner_creation_notsuccess_without_allrequiredfields
    value  = { name: "" ,  email: "" , password:"" , address:""}
    response = post  "/owners", value
    assert_equal(response.status,302)
  end

  def test_owner_email_check_present_in_db
    value = {email: @owner.email }
    response = post "/owners", value 
    assert_equal(response.status,302)
  end

end
