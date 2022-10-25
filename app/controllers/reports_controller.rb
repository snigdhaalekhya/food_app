class ReportsController < ApplicationController 
    skip_before_action :ensure_user_logged_in
    before_action :ensure_owner_logged_in  
    
end