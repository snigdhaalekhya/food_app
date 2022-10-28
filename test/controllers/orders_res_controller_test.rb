require_relative '../test_helper'
require "action_controller/railtie"

class OrdersResControllerTest < ActiveSupport::TestCase

    def setup
        super
        before_all
    end

    def before_all
        Order.all.destroy_all
        Owner.all.destroy_all
        User.all.destroy_all
        @user = User.new({name: "test" , mobile_no: 1223324222 , email: "email@email" , password:"Abcdef@1" , address:"address"})
        @user.save
        @owner = Owner.new({name: "test_owner" , email: "ownertest@worker" , password:"Abcdef@1" , address:"address"})
        @owner.save
        @order = Order.new({user_id: @user.id, menu: "menuname*2*500", status:"Pending" , owner_id:@owner.id})
        @order.save
        value = {identity: "Owner", email: @owner.email , password:@owner.password }
        post  "/signin_restaurant" , value
    end

    def test_update
        field_value = {status: "Add to queue"}
        response = put "/orders1/#{@order.id}" , field_value
        #assert_equal(response.header["Location"],"http://example.org/orders1")
        assert_equal(response.status,302)
    end
end