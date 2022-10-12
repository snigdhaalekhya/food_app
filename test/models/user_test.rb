require "minitest/autorun"
require "action_controller"

class TestUser < ActionController::TestCase
    include User
    def test_user_create
        debugger
        user = User.new
        assert user.save!
    end
end