require_relative '../test_helper'

class CartsControllerTest < ActiveSupport::TestCase

    def setup
        super
        User.all.destroy_all
        @user = FactoryGirl.create(:user)
        Menu.all.destroy_all
        @menu = FactoryGirl.create(:menu)
        value = { mobile_no: @user.mobile_no, password: @user.password }
        post  "/signin_users" , value
    end
    
     def test_cart_count_updation_for_exisiting
        Cart.all.destroy_all
        cart_existed = Cart.new({user_id: @user.id, menu_id: @menu.id, count: AllConstants::VALUE, owner_id: AllConstants::VALUE})
        cart_existed.save
        response = get "/carts/#{@menu.id}" 
        assert_equal(Cart.last.count,cart_existed.count + 1 )
        assert_equal(response.status, 302)
     end

     def test_cart_creation_for_notexisiting
        response = get "/carts/#{@menu.id}" 
        assert_equal(Cart.last.count, 1)
        assert_equal(response.status, 302)
     end

     def test_remove_cart_for_alreadyexisted_count_gt1
         Cart.all.destroy_all
         cart_existed = FactoryGirl.create(:cart, user_id: @user.id, menu_id: @menu.id, count: AllConstants::COUNT)
         response = get "/carts/#{@menu.id}/remove" 
         assert_equal(Cart.last.count,cart_existed.count - 1 )
         assert_equal(response.status, 302)
     end

     def test_remove_cart_for_alreadyexisted_count_eq1
       Cart.all.destroy_all
       cart_existed = FactoryGirl.create(:cart, user_id: @user.id, menu_id: @menu.id )
       response = get "/carts/#{@menu.id}/remove" 
       assert_equal(response.status, 302)
   end
   
   def test_remove_cart_notexisted
     response = get "/carts/#{@menu.id}/remove" 
    assert_equal(response.status, 302)
 end
end
