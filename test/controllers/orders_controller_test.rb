require_relative '../test_helper'
require "action_controller/railtie"

class OrdersControllerTest < ActiveSupport::TestCase

    def setup
        super
        before_all
    end

    def before_all
        User.all.destroy_all
        Cart.all.destroy_all
        Menu.all.destroy_all
        Owner.all.destroy_all
        @owner = Owner.new({ id:1 ,name: "test_owner" , email: "ownertest@owner" , password:"Abcdef@1" , address:"address"})
        @owner.save
        @user = User.new({ name: "test" , mobile_no: 1223324222 , email: "email@email" , password:"Abcdef@1" , address:"address"})
        @user.save
        @menu = Menu.new({owner_id: 1, menu_name: "menuname", menu_cost: 100, menu_description:"des", menu_image:"https://media.istockphoto.com/photos/chicken-biriyani-picture-id1345624336?k=20&m=1345624336&s=612x612&w=0&h=0TSxrGelLdgZnvhZlfIcOq07y03Ioym4hRZOivZeXfI=", menu_category: "Breakfast"})
        @menu.save
        @cart = Cart.new({user_id: @user.id , menu_id: @menu.id , count: 1 , owner_id: 1})
        @cart.save
        value = { mobile_no: @user.mobile_no , password:@user.password }
        post  "/signin_users" , value
    end

    def test_create
        response = post "/orders"
        assert_equal(response.status,302)
        #assert_equal(response.header["Location"],"http://example.org/orders")
    end

    def test_update
        Order.all.destroy_all
        order = Order.new({user_id: @user.id, menu: "menuname*2*500", status:"Delivered" , owner_id:1})
        order.save
        response = put "/orders/#{order.id}"
        assert_equal(response.status,302)
        #assert_equal(response.header["Location"],"http://example.org/main")
    end
end