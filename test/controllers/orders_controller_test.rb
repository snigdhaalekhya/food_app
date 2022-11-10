require_relative '../test_helper'
class OrdersControllerTest < ActiveSupport::TestCase

    def setup
        super
        User.all.destroy_all
        Cart.all.destroy_all
        Menu.all.destroy_all
        Order.all.destroy_all
        Owner.all.destroy_all
        @owner = FactoryGirl.create(:owner, id: 1)
        @order = FactoryGirl.create(:order)
        @user = FactoryGirl.create(:user)
        @menu = FactoryGirl.create(:menu)
        @cart = FactoryGirl.create(:cart, user_id: @user.id, menu_id: @menu.id)
        value = { mobile_no: @user.mobile_no, password: @user.password }
        post  "/signin_users", value
    end

    def test_order_creation
        response = post "/orders"
        assert_equal(Order.last.user_id, @user.id)
        field_mail = ActionMailer::Base.deliveries.first
        assert_equal(field_mail['from'].to_s, AllConstants::MAIL)
        assert_equal( field_mail['to'].to_s, @owner.email)
        mail = ActionMailer::Base.deliveries.last
        assert_equal(mail['from'].to_s, AllConstants::MAIL)
        assert_equal( mail['to'].to_s, @user.email)
        assert_equal(response.status, 302)
    end

    def test_orderstatus_update_if_delivered
        Order.all.destroy_all
        order = FactoryGirl.create(:order, status: AllConstants::DELIVERED)
        response = put "/orders/#{order.id}"
        assert_equal(Order.last.status, AllConstants::CONFIRM_SUCCESS)
        assert_equal(response.status, 302)
    end

    def test_orderstatus_update_if_notdelivered
        Order.all.destroy_all
        order = FactoryGirl.create(:order, status: AllConstants::DELIVERED)
        response = put "/orders/#{order.id}/updateto_not_delivered"
        assert_equal(Order.last.status, AllConstants::NOT_DELIVERED)
        assert_equal(response.status, 302)
    end
end
