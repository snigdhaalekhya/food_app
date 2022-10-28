require_relative '../test_helper'
require "action_controller/railtie"

class MenusControllerTest < ActiveSupport::TestCase

    def setup
        super
        before_all
    end

    def before_all
        Order.all.destroy_all
        Owner.all.destroy_all
        Menu.all.destroy_all
        @order = Order.new({user_id: 1, menu: "menuname*2*500", status:"Pending" , owner_id:1})
        @order.save
        @owner = Owner.new({ name: "test_owner" , email: "ownertest@owner" , password:"Abcdef@1" , address:"address"})
        @owner.save
        @menu = Menu.new({owner_id: 1, menu_name: "menuname", menu_cost: 100, menu_description:"des", menu_image:"https://media.istockphoto.com/photos/chicken-biriyani-picture-id1345624336?k=20&m=1345624336&s=612x612&w=0&h=0TSxrGelLdgZnvhZlfIcOq07y03Ioym4hRZOivZeXfI=", menu_category: "Breakfast"})
        @menu.save
        value = {identity: "Owner", email: @owner.email , password:@owner.password }
        post  "/signin_restaurant" , value
    end

    def test_create_success
        field_value ={ menu_name: "menuname", menu_cost: 100, menu_description:"des", menu_image:"https://media.istockphoto.com/photos/chicken-biriyani-picture-id1345624336?k=20&m=1345624336&s=612x612&w=0&h=0TSxrGelLdgZnvhZlfIcOq07y03Ioym4hRZOivZeXfI=", menu_category: "Breakfast"}
        response = post "/menus", field_value
        assert_equal(response.status, 302)
        #assert_equal(response.header["Location"],"http://example.org/menus")  
    end

    def test_create_notsuccess
        field_value ={ menu_name: "menu_name", menu_cost: 100, menu_description:"des", menu_image:"https://media.istockphoto.com/photos/chicken-biriyani-picture-id1345624336?k=20&m=1345624336&s=612x612&w=0&h=0TSxrGelLdgZnvhZlfIcOq07y03Ioym4hRZOivZeXfI=", menu_category: "Breakfast"}
        response = post "/menus", field_value
        assert_equal(response.status, 302)
        # assert_equal(response.header["Location"],"http://example.org/menus/new")
    end

    def test_create_notsuccess_without_allrequiredfields
        field_value ={ menu_name: "", menu_cost: "", menu_description:"", menu_image:"", menu_category: ""}
        response = post "/menus", field_value
        assert_equal(response.status, 302)
        # assert_equal(response.header["Location"],"http://example.org/menus/new")
    end

    def test_create_notsuccess_without_name
        field_value ={ menu_name: "", menu_cost: 100, menu_description:"des", menu_image:"https://media.istockphoto.com/photos/chicken-biriyani-picture-id1345624336?k=20&m=1345624336&s=612x612&w=0&h=0TSxrGelLdgZnvhZlfIcOq07y03Ioym4hRZOivZeXfI=", menu_category: "Breakfast"}
        response = post "/menus", field_value
        assert_equal(response.status, 302)
        # assert_equal(response.header["Location"],"http://example.org/menus/new")
    end

    def test_create_notsuccess_without_name_cost
        field_value ={ menu_name: "", menu_cost: "", menu_description:"des", menu_image:"https://media.istockphoto.com/photos/chicken-biriyani-picture-id1345624336?k=20&m=1345624336&s=612x612&w=0&h=0TSxrGelLdgZnvhZlfIcOq07y03Ioym4hRZOivZeXfI=", menu_category: "Breakfast"}
        response = post "/menus", field_value
        assert_equal(response.status, 302)
        # assert_equal(response.header["Location"],"http://example.org/menus/new")
    end

    def test_edit
        response = get "/menus/#{@menu.id}/edit"
        assert_equal(response.status,200)
    end

    def test_update_cost
       response =  put "/menus/#{@menu.id}", menu: { menu_name:@menu.menu_name,menu_cost:200,  menu_description: @menu.menu_description, menu_image: @menu.menu_image , menu_category: @menu.menu_category} 
       assert_equal(response.status,302)
    end

    def test_update_name
        response = put "/menus/#{@menu.id}", menu: { menu_name:"mm", menu_cost:@menu.menu_cost,  menu_description: @menu.menu_description, menu_image: @menu.menu_image , menu_category: @menu.menu_category} 
        assert_equal(response.status,302)
    end

    def test_update_category
        response = put "/menus/#{@menu.id}", menu: { menu_name:@menu.menu_name, menu_cost:@menu.menu_cost,  menu_description: @menu.menu_description, menu_image: @menu.menu_image , menu_category: "Lunch"} 
        assert_equal(response.status,302)
    end

    def test_update_description
        response = put "/menus/#{@menu.id}", menu: { menu_name:@menu.menu_name, menu_cost:@menu.menu_cost,  menu_description: "fulldes", menu_image: @menu.menu_image , menu_category:@menu.menu_category} 
        assert_equal(response.status,302)
    end

    def test_update_image
        response = put "/menus/#{@menu.id}", menu: { menu_name:@menu.menu_name, menu_cost:@menu.menu_cost,  menu_description: @menu.menu_description, menu_image:"https://i.timesnowhindi.com/stories/Egg-bonda.jpg" , menu_category:@menu.menu_category} 
        assert_equal(response.status,302)
    end

    def test_destroy
        response = delete "/menus/#{@menu.id}"
        #assert_equal(response.header["Location"],"http://example.org/menus")   
        assert_equal(response.status,302)
    end

    def test_category
        field_value = {menu_category: @menu.menu_category}
        response = get "/menus/category_wise", field_value
        assert_equal(response.status,200)
    end
end