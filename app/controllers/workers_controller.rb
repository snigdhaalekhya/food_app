class WorkersController < ApplicationController 
    skip_before_action :ensure_user_logged_in  
    before_action :ensure_owner_logged_in
    skip_before_action :ensure_owner_logged_in
 
     def index     
     end
 
     def create
         worker=Worker.new(
            name: params[:name],
             mobile_no: params[:mobile_no],
             email: params[:email],
             password: params[:password],
             address: params[:address]
          )
          #session[:current_user_id]= user.id
            if worker.save
               redirect_to workers_path
         #response_text= "new todo #{new_todo.id}"
         #render plain:  response_text
             else
                flash[:error]= menu.errors.full_messages.join(", ")
                redirect_to "/workers/new"
             end
     end
 
     def new
     end
 end