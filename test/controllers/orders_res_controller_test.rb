require_relative '../test_helper'
class OrdersResControllerTest < ActiveSupport::TestCase

    def setup
        super
        User.all.destroy_all
        Owner.all.destroy_all
        Order.all.destroy_all
        @user = FactoryGirl.create(:user)
        @owner = FactoryGirl.create(:owner)
        @order = FactoryGirl.create(:order, user_id: @user.id, owner_id: @owner.id)
        value = { identity: "Owner", email: @owner.email , password: @owner.password }
        post  "/signin_restaurant", value
    end

    def test_orderstatus_update
        field_value = { status: AllConstants::ADD_TO_QUEUE }
        response = put "/orders1/#{@order.id}" , field_value
        assert_equal(Order.last.status, field_value[:status])
        mail = ActionMailer::Base.deliveries.last
        assert_equal(mail['from'].to_s , AllConstants::MAIL)
        assert_equal( mail['to'].to_s, @user.email)
        assert_equal(response.status,302)
    end

    def test_send_mail_if_reason_notnull
        field_value = { status: AllConstants::REMOVE, reason: Faker::Lorem.paragraph }
        response = post "/orders1/#{@order.id}/send_mail", field_value
        assert_equal(Order.last.status, field_value[:status])
        mail = ActionMailer::Base.deliveries.last
        assert_equal(mail['from'].to_s, @owner.email)
        assert_equal( mail['to'].to_s, @user.email)
        assert_equal(response.status, 302)
    end

    def test_send_mail_if_reason_null
        field_value = { status: AllConstants::REMOVE, reason: "" }
        response = post "/orders1/#{@order.id}/send_mail", field_value
        assert_equal(response.status, 302)
    end
end
