require_relative '../test_helper'
require "action_controller/railtie"

class OwnersControllerTest < ActiveSupport::TestCase

  def setup
    super
    before_all
  end

  def before_all
    Owner.all.destroy_all
    @owner = Owner.new({ name: "test_owner" , email: "ownertest@worker" , password:"Abcdef@1" , address:"address"})
    @owner.save
  end

  def test_owner_create
    value = {name: "name", email:"email@email", password: "Abcdef@1", address:"worker"}
    post "/owners", value
    # puts "success"
    assert_redirected_to "/orders1"
  end

  def test_owner_email_check
    field_value = {email: @owner.email }
    post "/owners", field_value 
    # puts "This email is already registered. Please retry."
    assert_equal "This email is already registered. Please retry.", flash[:error]
    assert_redirected_to "/owners/new"
  end

end
