class MainController < ApplicationController
  before_action :menuwise_category, only: [:category_wise]
 
  def index
    if !params[:search].blank?
        @result_count =  Menu.search(params[:search]).count
        if @result_count > 0
            @results = Menu.search(params[:search])
        end
        elsif
            @results = Menu.all
        end
    end
end
