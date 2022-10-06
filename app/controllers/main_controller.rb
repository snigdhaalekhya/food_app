class MainController < ApplicationController
    
    def index
        if !params[:search].blank?
            @results = Menu.search(params[:search])     
        end
    end

    def new
    end

    def category_wise
        @menus_category = Menu.where(menu_category: params[:menu_category])
    end 
end