class LandingController < ApplicationController

   def index
     if current_user
       redirect_to dashboard_path
     else
     end
   end
 end
