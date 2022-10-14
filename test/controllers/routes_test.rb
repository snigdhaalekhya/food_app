require 'test_helper'
# require "minitest/autorun"
# require "action_controller"


class UsersController::RoutesTest < ActionController::TestCase
  def test_routes
    # assert_routing '/users/new',   controller: 'users', action: 'new'
    assert_routing '/users', controller: 'users', action: 'create'
  end
end