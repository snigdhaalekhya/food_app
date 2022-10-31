require_relative '../test_helper'

class OrdersResControllerTest < ActiveSupport::TestCase

    def setup
        super
        User.all.destroy_all
        Owner.all.destroy_all
        Order.all.destroy_all
        @user = FactoryGirl.create(:user)
        @owner = FactoryGirl.create(:owner)
        @order = FactoryGirl.create(:order,user_id: @user.id,owner_id:@owner.id)
        value = {identity: "Owner", email: @owner.email , password:@owner.password }
        post  "/signin_restaurant" , value
    end

    def test_orderstatus_update
        field_value = {status: "Add to queue"}
        response = put "/orders1/#{@order.id}" , field_value
        assert_equal(Order.last.status, field_value[:status])
        mail = ActionMailer::Base.deliveries.last
        assert_equal(mail['from'].to_s , 'ammualekhya6@gmail.com')
        assert_equal( mail['to'].to_s, @user.email)
        assert_equal(response.status,302)
    end
end