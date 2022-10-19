# require 'minitest/autorun'
require "active_support"

class UserTest < ActiveSupport::TestCase
    include User
    test 'invalid - no campaign' do
        county = User.new(name: "snigdha")      
        assert county.valid?, 'Campplay passed without a name'
      end

#   def test_notvalid
#     @post = User.new(name: 'Hello World')
#     refute @post.valid?, 'Campplay passed without a campaign_id'
   
#   end
#   def test_create
#     post :create
#     assert_response 200
#     # assert_includes @post.title, @response.body
#   end
end