class UsersController < ApplicationController
 def index
 	@user = User.find(params[:id]) 
  @playlists = Playlist.where(creator: @user.id, published: true )

	respond_to do |format|
    format.html         	
 	end

 	rescue ActiveRecord::RecordNotFound
	 	respond_to do |format|
      flash[:notice] = "Es existiert kein Benutzer mit der ID " + params[:id]
	  	format.html  { render action: "no_user"}        	
	  end 
  flash.clear
 end
 def new
   @user = User.new
 end
 def create
   @user = User.new(params[:user])
   if @user.save
     redirect_to root_url, :notice => "Erfolgreich angemeldet!"
   else
     render "new"
   end
 end
 def update
   @user = User.find(session[:user_id])
   respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
 end

 def show
    if logged_in
     @playlists = Playlist.where(creator: current_user.id)
     @songs = Song.all(:joins => :histories, :conditions => {:histories => {:user_id => current_user.id}}, :select => "histories.played_at as played_at, histories.id as hid, songs.*", :order => "histories.played_at DESC")
    else
      redirect_to run_path, notice: 'You have to login to see user information!'
    end
 end

 def edit
   @user = User.find(session[:user_id])
 end
end