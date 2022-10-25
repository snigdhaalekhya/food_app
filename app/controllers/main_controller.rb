class MainController < ApplicationController
    before_action :category, only: [:category_wise]
    def index
        if !params[:search].blank?
            @results = Menu.search(params[:search])     
        end
    end

    def category_wise
       category
    end 
end