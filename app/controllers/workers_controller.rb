class WorkersController < ApplicationController 
    skip_before_action :ensure_user_logged_in  
    before_action :ensure_owner_logged_in
 
   def index  
   end
 
   def create
      worker = findby_params(email: params[:email])
      if worker
         flash[:error] = "This email is already registered. Please retry."
         redirect_to new_worker_path 
      elsif findby_params(mobile_no: params[:mobile_no])
         flash[:error] = "This mobile no is already registered. Please retry."
         redirect_to new_worker_path 
      else
          worker = Worker.new(name:params[:name] , mobile_no:params[:mobile_no] , email:params[:email] , password:params[:password] , address:params[:address])
            if worker.save
               # session[:current_owner_id] = worker.email
               # session[:bool_owner] = true
               redirect_to workers_path
            else
                flash[:error] = worker.errors.full_messages.join(", ")
                redirect_to new_worker_path
            end
      end
   end
 
   def new
   end

   def show_customers
   end
   

   private 
    def findby_params(params = {})
        Worker.find_by(params)
    end

 end