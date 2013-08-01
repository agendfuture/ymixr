class SessionsController < ApplicationController
 def new
 end

 def create
 	user = User.find_by_email(params[:email])
 	if user && user.authenticate(params[:password])
     session[:user_id] = user.id
     flash.now.alert = "Logged in!"
     redirect_to run_url, :notice => "Logged in!"
   	else
     flash.now.alert = "Falsche E-Mail oder falsches Passwort"
     render "new"
   	end
 end

 def destroy
   session[:user_id] = nil
   redirect_to root_url, :notice => "Logged out!"
 end
end