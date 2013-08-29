class PlaylistEntriesController < ApplicationController
 def create
  if logged_in      
    if !session[:playlist].nil?
      params[:id] = (params[:id] == session[:playlist].id)? params[:id] : session[:playlist].id

      @song = Song.findOrCreate(params[:sid], params[:title], params[:artist])
      
      @playlist_entry = PlaylistEntry.create(song_id: @song.id, playlist_id: params[:id])
      @playlist_entry.order = PlaylistEntry.where(song_id: @song.id, playlist_id: params[:id]).count
      if !@playlist_entry.save
        flash[:notice] = "Error while creating a playlist entry for the current song."
      end
    end
    
    respond_to do |format|
      format.html {render :text => "{\"order\" : #{@playlist_entry.order}}"}
      format.js 
    end      
  else 
    redirect_to run_path, notice: 'You have to login to create or change playlists!'      
  end
 end

 def remove
   if logged_in
      if !session[:playlist].nil?
        # inner join wäre ebenfalls möglich
        @song_id = Song.find_by_sid(params[:sid]).id
        @playlist_entry = PlaylistEntry.where(playlist_id: session[:playlist].id, song_id: @song_id, order: params[:order]).first
        @playlist_entry.destroy
      end    
      render :nothing => true
    else 
      redirect_to run_path, notice: 'You have to login to remove songs from a playlist!'
    end
 end

 def destroy
   if logged_in
      if !session[:playlist].nil?
        params[:playlist_id] = (params[:playlist_id] == session[:playlist].id)? params[:playlist_id] : session[:playlist].id

        @playlist_entry = PlaylistEntry.find(params[:playlist_entry_id])
        @playlist_entry.destroy
      end    
      redirect_to :back
    else 
      redirect_to run_path, notice: 'You have to login to remove songs from a playlist!'
    end
 end
end