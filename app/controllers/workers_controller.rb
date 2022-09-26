gem 'actionpack-action_caching'
require 'actionpack/action_caching'
class WorkersController < ApplicationController 
    skip_before_action :ensure_user_logged_in  
    before_action :ensure_owner_logged_in
    skip_before_action :ensure_owner_logged_in
 
   def index  
      if Owner.find_by(email: current_owner.email)
         @owner_worker= current_owner.email
     elsif Worker.find_by(email: current_owner.email)
         @owner_worker= current_owner.email
     end   
   end
 
   def create
      worker=Worker.find_by(email: params[:email])
      if worker
         flash[:error]="This email is already registered. Please retry."
         redirect_to new_worker_path 
      elsif Worker.find_by(mobile_no: params[:mobile_no])
         flash[:error]="This mobile no is already registered. Please retry."
         redirect_to new_worker_path 
      else
         worker=Worker.new(
            name: params[:name],
             mobile_no: params[:mobile_no],
             email: params[:email],
             password: params[:password],
             address: params[:address]
          )
          session[:current_worker_id]= worker.id
            if worker.save
               redirect_to workers_path
         #response_text= "new todo #{new_todo.id}"
         #render plain:  response_text
            else
                flash[:error]= worker.errors.full_messages.join(", ")
                redirect_to "/workers/new"
            end
      end
   end
 
   def new
   end
 end