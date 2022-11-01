require_relative '../test_helper'

class MenusControllerTest < ActiveSupport::TestCase

    def setup
        super
        Order.all.destroy_all
        @order = FactoryGirl.create(:order)
        Owner.all.destroy_all
        @owner = FactoryGirl.create(:owner)
        Menu.all.destroy_all
        @menu = FactoryGirl.create(:menu)
        value = {identity: "Owner", email: @owner.email , password:@owner.password }
        post  "/signin_restaurant" , value
    end

    def test_menu_creation_success
        field_value ={ menu_name: "Menuname", menu_cost: 10, menu_description:Faker::Lorem.paragraph, menu_image:AllConstants::IMAGE, menu_category: AllConstants::CATEGORY[0]}
        response = post "/menus", field_value
        assert_equal(Menu.last.menu_name, field_value[:menu_name])
        assert_equal(response.status, 302) 
    end

    def test_menu_creation_notsuccess
        field_value ={ menu_name: "menu_name", menu_cost: 10, menu_description:Faker::Lorem.paragraph, menu_image:AllConstants::IMAGE, menu_category: AllConstants::CATEGORY[0]}
        response = post "/menus", field_value
        assert_equal(response.status, 302)
    end

    def test_menu_creation_gt18_notsuccess
        field_value ={ menu_name: "menunamehkfsnldfmsdbnscnlncslkdnl", menu_cost: 10, menu_description:Faker::Lorem.paragraph, menu_image:AllConstants::IMAGE, menu_category: AllConstants::CATEGORY[0]}
        response = post "/menus", field_value
        assert_equal(response.status, 302)
    end

    def test_menu_creation_notsuccess_without_allrequiredfields
        field_value ={ menu_name: "", menu_cost: "", menu_description:"", menu_image:"", menu_category: ""}
        response = post "/menus", field_value
        assert_equal(response.status, 302)
    end

    def test_menu_creation_notsuccess_without_name
        field_value ={ menu_name: "", menu_cost: 10, menu_description:Faker::Lorem.paragraph, menu_image:AllConstants::IMAGE, menu_category: AllConstants::CATEGORY[0]}
        response = post "/menus", field_value
        assert_equal(response.status, 302)
    end

    def test_menu_creation_notsuccess_without_name_cost
        field_value ={ menu_name: "", menu_cost: "", menu_description:Faker::Lorem.paragraph, menu_image:AllConstants::IMAGE, menu_category: AllConstants::CATEGORY[0]}
        response = post "/menus", field_value
        assert_equal(response.status, 302)
    end

    def test_edit
        response = get "/menus/#{@menu.id}/edit"
        assert_equal(response.status,200)
    end

    def test_update_cost
       response =  put "/menus/#{@menu.id}",  field_value = {menu: { menu_name:@menu.menu_name,menu_cost:200, menu_description: @menu.menu_description, menu_image: @menu.menu_image , menu_category: @menu.menu_category}}
       assert_equal(Menu.last.menu_cost, field_value[:menu][:menu_cost])
       assert_equal(response.status,302)
    end

    def test_update_name
        response = put "/menus/#{@menu.id}",field_value = { menu: { menu_name:"mm",menu_cost:200, menu_description: @menu.menu_description, menu_image: @menu.menu_image , menu_category: @menu.menu_category}}
 
        assert_equal(Menu.last.menu_name, field_value[:menu][:menu_name])
        assert_equal(response.status,302)
    end

    def test_update_category
        response = patch "/menus/#{@menu.id}", field_value = {menu: { menu_name:@menu.menu_name, menu_cost:@menu.menu_cost, menu_description: @menu.menu_description, menu_image: @menu.menu_image , menu_category: "Lunch"}}
        assert_equal(Menu.last.menu_category, field_value[:menu][:menu_category])
        assert_equal(response.status,302)
    end

    def test_update_description
        response = put "/menus/#{@menu.id}", field_value = {menu: { menu_name:@menu.menu_name, menu_cost:@menu.menu_cost, menu_description: "fulldes", menu_image: @menu.menu_image , menu_category:@menu.menu_category}}
        assert_equal(Menu.last.menu_description, field_value[:menu][:menu_description])
        assert_equal(response.status,302)
    end

    def test_update_image
        response = put "/menus/#{@menu.id}",field_value = { menu: { menu_name:@menu.menu_name, menu_cost:@menu.menu_cost, menu_description: @menu.menu_description, menu_image:"https://i.timesnowhindi.com/stories/Egg-bonda.jpg" , menu_category:@menu.menu_category}}
        assert_equal(Menu.last.menu_image, field_value[:menu][:menu_image])
        assert_equal(response.status,302)
    end

    def test_destroy
        response = delete "/menus/#{@menu.id}"
        assert_equal(response.status,302)
    end

    def test_category_present
        field_value = {menu_category: @menu.menu_category}
        response = get "/menus/category_wise", field_value
        assert_equal(response.status,200)
    end

    def test_category_notpresent
        field_value = {menu_category: "y"}
        response = get "/menus/category_wise", field_value
        assert_equal(response.status,200)
    end
end