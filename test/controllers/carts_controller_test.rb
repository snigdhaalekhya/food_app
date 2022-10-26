require_relative '../test_helper'
require "action_controller/railtie"

class CartsControllerTest < ActiveSupport::TestCase
# include ApplicationController

    def setup
        super
        before_all
      end
    
      def before_all
        Cart.all.destroy_all
        Menu.all.destroy_all
        @cart = Cart.new({id: 1,  user_id: 1  , menu_id: 1 , count: 1 , owner_id: 1})
        @cart.save
        User.all.destroy_all
        @user = User.new({id: 1, name: "test" , mobile_no: 1223324222 , email: "email@email" , password:"Abcdef@1" , address:"address"})
        @user.save
        # debugger
        @menu = Menu.new({owner_id: 1, menu_name: "menuname", menu_cost: 100, menu_description:"des", menu_image:"https://media.istockphoto.com/photos/chicken-biriyani-picture-id1345624336?k=20&m=1345624336&s=612x612&w=0&h=0TSxrGelLdgZnvhZlfIcOq07y03Ioym4hRZOivZeXfI=", menu_category: "Breakfast"})
        @menu.save
        # debugger
        value = { mobile_no: @user.mobile_no , password:@user.password }
        post  "/signin_users" , value
      end

     def test_show
         debugger
        
        field_value  = {'id'=> @menu.id }
        # { user_id: 1 , menu_id: 2 , count:1 , owner_id: 1}
        get "/carts/:id" , field_value
        assert_equal 
     end

     def test_show_count
        field_value = {menu_id: @cart.menu_id }
         debugger
         get "/carts/:id", field_value
        #  if cart.save
        #     puts ">1"
        #  end
     end
end