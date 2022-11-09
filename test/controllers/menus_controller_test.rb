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
        value = {identity: "Owner", email: @owner.email, password: @owner.password }
        post  "/signin_restaurant" , value
    end

    def test_menu_creation_success
        field_value =  pass_params(Faker::Lorem.characters(number: 18, min_alpha: 18, min_numeric: 0), Faker::Number.number[4], Faker::Lorem.paragraph, AllConstants::IMAGE,  AllConstants::CATEGORY[0])
        response = post "/menus", field_value
        assert_equal(Menu.last.menu_name, field_value[:menu_name])
        assert_equal(response.status, 302) 
    end

    def test_menu_creation_notsuccess
        field_value =  pass_params("menu_name", Faker::Number.number[4], Faker::Lorem.paragraph, AllConstants::IMAGE ,  AllConstants::CATEGORY[0])
        response = post "/menus", field_value
        assert_not_equal(Menu.last.menu_name, field_value[:menu_name])
        assert_equal(response.status, 302)
    end

    def test_menu_creation_gt18_notsuccess
        field_value =  pass_params(Faker::Lorem.characters(number: 19, min_alpha: 18, min_numeric: 0), Faker::Number.number[4], Faker::Lorem.paragraph , AllConstants::IMAGE ,  AllConstants::CATEGORY[0])
        response = post "/menus", field_value
        assert_not_equal(Menu.last.menu_name, field_value[:menu_name])
        assert_equal(response.status, 302)
    end

    def test_menu_creation_notsuccess_without_allrequiredfields
        field_value =  pass_params("", "", "", "", "")
        response = post "/menus", field_value
        assert_not_equal(Menu.last.menu_name, field_value[:menu_name])
        assert_not_equal(Menu.last.menu_cost, field_value[:menu_cost])
        assert_not_equal(Menu.last.menu_description, field_value[:menu_description])
        assert_not_equal(Menu.last.menu_image, field_value[:menu_image])
        assert_not_equal(Menu.last.menu_category, field_value[:menu_category])
        assert_equal(response.status, 302)
    end

    def test_menu_creation_notsuccess_without_name
        field_value =  pass_params("", Faker::Number.number[4], Faker::Lorem.paragraph, AllConstants::IMAGE,  AllConstants::CATEGORY[0])
        response = post "/menus", field_value
        assert_not_equal(Menu.last.menu_name, field_value[:menu_name])
        assert_equal(response.status, 302)
    end

    def test_menu_creation_notsuccess_without_name_cost
        field_value =  pass_params("", "",  Faker::Lorem.paragraph, AllConstants::IMAGE,  AllConstants::CATEGORY[0])
        response = post "/menus", field_value
        assert_not_equal(Menu.last.menu_name, field_value[:menu_name])
        assert_not_equal(Menu.last.menu_cost, field_value[:menu_cost])
        assert_equal(response.status, 302)
    end

    def test_edit
        response = get "/menus/#{@menu.id}/edit"
        assert_equal(response.status, 200)
    end

    def test_update_cost
       response =  put "/menus/#{@menu.id}",  field_value =  pass_params_for_update(@menu.menu_name, Faker::Number.number[4], @menu.menu_category, @menu.menu_image,  @menu.menu_category)
       assert_equal(Menu.last.menu_cost, field_value[:menu][:menu_cost])
       assert_equal(response.status, 302)
    end

    def test_update_name
        response = put "/menus/#{@menu.id}", field_value = pass_params_for_update( Faker::Lorem.characters(number: 10, min_alpha: 10, min_numeric: 0), @menu.menu_cost, @menu.menu_category, @menu.menu_image , @menu.menu_category)
        assert_equal(Menu.last.menu_name, field_value[:menu][:menu_name])
        assert_equal(response.status, 302)
    end

    def test_update_category
        response = patch "/menus/#{@menu.id}", field_value = pass_params_for_update(@menu.menu_name, @menu.menu_cost, @menu.menu_category, @menu.menu_image, "Lunch")
        assert_equal(Menu.last.menu_category, field_value[:menu][:menu_category])
        assert_equal(response.status, 302)
    end

    def test_update_description
        response = put "/menus/#{@menu.id}", field_value = pass_params_for_update(@menu.menu_name, @menu.menu_cost, Faker::Lorem.paragraph, @menu.menu_image, @menu.menu_category)
        assert_equal(Menu.last.menu_description, field_value[:menu][:menu_description])
        assert_equal(response.status, 302)
    end

    def test_update_image
        field_value = pass_params_for_update(@menu.menu_name, @menu.menu_cost, @menu.menu_description, "https://i.timesnowhindi.com/stories/Egg-bonda.jpg", @menu.menu_category)
        response = put "/menus/#{@menu.id}", field_value 
        assert_equal(Menu.last.menu_image, field_value[:menu][:menu_image])
        assert_equal(response.status, 302)
    end

    def test_update_fail
        field_value = pass_params_for_update(Faker::Name.name[19], @menu.menu_cost, @menu.menu_description, @menu.menu_image, @menu.menu_category)
        response = put "/menus/#{@menu.id}", field_value
        assert_not_equal(Menu.last.menu_name,field_value[:menu][:menu_name])
        assert_equal(response.status, 302)
    end

    def test_destroy
        response = delete "/menus/#{@menu.id}"
        assert_equal(response.status, 302)
    end

    def test_category_present
        field_value = {menu_category: @menu.menu_category}
        response = get "/menus/category_wise", field_value
        assert_equal(response.status, 200)
    end

    def test_category_notpresent
        field_value = {menu_category: Faker::Lorem.paragraph}
        response = get "/menus/category_wise", field_value
        assert_equal(response.status, 200)
    end

    private
    def pass_params(menu_name, menu_cost, menu_description, menu_image, menu_category)
        field_value = { menu_name: menu_name, menu_cost: menu_cost, menu_description: menu_description, menu_image: menu_image , menu_category: menu_category}
    end

    def pass_params_for_update(menu_name, menu_cost, menu_description, menu_image, menu_category)
        field_value = {menu: { menu_name: menu_name, menu_cost: menu_cost, menu_description: menu_description, menu_image: menu_image, menu_category: menu_category}}  
    end

end
