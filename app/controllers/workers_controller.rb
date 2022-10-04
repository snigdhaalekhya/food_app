gem 'actionpack-action_caching'
require 'actionpack/action_caching'
class WorkersController < ApplicationController 
    skip_before_action :ensure_user_logged_in  
    before_action :ensure_owner_logged_in
 
   def index  
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
          worker = Worker.worker_create(params[:name],params[:mobile_no], params[:email],params[:password],params[:address])
          session[:current_worker_id]= worker.id
            if worker.save
               redirect_to workers_path
            else
                flash[:error]= worker.errors.full_messages.join(", ")
                redirect_to "/workers/new"
            end
      end
   end
 
   def new
   end
 end