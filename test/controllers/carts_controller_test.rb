require_relative '../test_helper'
require "action_controller/railtie"

class CartsControllerTest < ActiveSupport::TestCase
# include ApplicationController

    def setup
        super
        before_all
    end
    
      def before_all
        # Cart.all.destroy_all
        Menu.all.destroy_all
        User.all.destroy_all
        @user = User.new({name: "test" , mobile_no: 1223324222 , email: "email@email" , password:"Abcdef@1" , address:"address"})
        @user.save
        @menu = Menu.new({owner_id: 1, menu_name: "menuname", menu_cost: 100, menu_description:"des", menu_image:"https://media.istockphoto.com/photos/chicken-biriyani-picture-id1345624336?k=20&m=1345624336&s=612x612&w=0&h=0TSxrGelLdgZnvhZlfIcOq07y03Ioym4hRZOivZeXfI=", menu_category: "Breakfast"})
        @menu.save
        value = { mobile_no: @user.mobile_no , password:@user.password }
        post  "/signin_users" , value
      end

     def test_show_alreadyexisted
        Cart.all.destroy_all
        cart_existed = Cart.new({user_id: @user.id  , menu_id: @menu.id , count: 1 , owner_id: 1})
        cart_existed.save
        response = get "/carts/#{@menu.id}" 
        # assert_equal(response.header["Location"],"http://example.org/main")
        assert_equal(response.status, 302)
     end

     def test_show_notexisted
        response = get "/carts/#{@menu.id}" 
        #assert_equal(response.header["Location"],"http://example.org/main")
        assert_equal(response.status, 302)
     end

     def test_remove_alreadyexisted_count_gt1
         Cart.all.destroy_all
         cart_existed = Cart.new({user_id: @user.id  , menu_id: @menu.id , count: 2 , owner_id: 1})
         cart_existed.save
         response = get "/carts/#{@menu.id}/remove" 
         #assert_equal(response.header["Location"],"http://example.org/main")
         assert_equal(response.status, 302)
     end

     def test_remove_alreadyexisted_count_eq1
       Cart.all.destroy_all
       @cart_existed = Cart.new({user_id: @user.id  , menu_id: @menu.id , count: 1 , owner_id: 1})
       @cart_existed.save
       response = get "/carts/#{@menu.id}/remove" 
       #assert_equal(response.header["Location"],"http://example.org/main")
       assert_equal(response.status, 302)
   end
   
   def test_remove_notexisted
     response = get "/carts/#{@menu.id}/remove" 
    # assert_equal(response.header["Location"],"http://example.org/main")
    assert_equal(response.status, 302)
 end
end