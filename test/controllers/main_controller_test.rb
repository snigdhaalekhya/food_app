require_relative '../test_helper'
class MainControllerTest < ActiveSupport::TestCase

    def setup
        super
        User.all.destroy_all
        @user = FactoryGirl.create(:user)
        Menu.all.destroy_all
        @menu = FactoryGirl.create(:menu)
        value = { mobile_no: @user.mobile_no , password:@user.password }
        post  "/signin_users" , value
    end

    def test_index_search_success
        field_value = {search: "men"}
        response = get "/main", field_value
        assert_equal(response.status,200)
    end

    def test_index_blanksearch_success
        field_value = {search: ""}
        response = get "/main", field_value
        assert_equal(response.status,200)
    end

    def test_index_novalidsearch
        field_value = {search: "er"}
        response = get "/main", field_value
        assert_equal(response.status,200)
    end

    def test_category_present
        field_value = {menu_category: @menu.menu_category}
        response = get "/view_user/category_wise", field_value
        assert_equal(response.status,200)
    end

    def test_category_notpresent
        field_value = {menu_category: "y"}
        # debugger
        response = get "/view_user/category_wise", field_value
        assert_equal(response.status,200)
    end

end