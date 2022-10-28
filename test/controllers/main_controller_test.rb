require_relative '../test_helper'
require "action_controller/railtie"

class MainControllerTest < ActiveSupport::TestCase

    def setup
        super
        before_all
    end

    def before_all
        Menu.all.destroy_all
        User.all.destroy_all
        @user = User.new({id: 1, name: "test" , mobile_no: 1223324222 , email: "email@email" , password:"Abcdef@1" , address:"address"})
        @user.save
        @menu = Menu.new({owner_id: 1, menu_name: "menuname", menu_cost: 100, menu_description:"des", menu_image:"https://media.istockphoto.com/photos/chicken-biriyani-picture-id1345624336?k=20&m=1345624336&s=612x612&w=0&h=0TSxrGelLdgZnvhZlfIcOq07y03Ioym4hRZOivZeXfI=", menu_category: "Breakfast"})
        @menu.save
        value = { mobile_no: @user.mobile_no , password:@user.password }
        post  "/signin_users" , value
    end

    def test_index_search_success
        field_value = {search: "men"}
        response = get "/main", field_value
        assert_equal(response.status,200)
    end

    def test_category
        field_value = {menu_category: @menu.menu_category}
        response = get "/view_user/category_wise", field_value
        assert_equal(response.status,200)
    end

end