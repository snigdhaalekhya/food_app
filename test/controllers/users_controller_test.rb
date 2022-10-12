require "minitest/autorun"
require "action_controller"

class TestUser < ActionController::TestCase
    def test_create_one
        post :create, user:{ name: "snigdha", email: 'abc@gmail' }
        # user = User.new
        # assert user.save!
    end
end