class PlaylistEntriesController < ApplicationController
 def create
  if choosed_own_playlist      
      params[:id] = (params[:id] == session[:playlist].id)? params[:id] : session[:playlist].id

      song = Song.findOrCreate(params[:sid], params[:title], params[:artist])
   
      entry = PlaylistEntry.create(playlist_id: params[:id], song_id: song.id)

      if !entry.save
        flash[:notice] = "Error while creating a new playlist entry!"
      end

    respond_to do |format|
      format.html {render :text => "{\"id\" : #{entry.id}}"}
      format.js 
    end      
  else 
    redirect_to run_path, notice: 'You have to login to create or change playlists!'      
  end
 end

 def destroy
   if choosed_own_playlist
      if !(entry = PlaylistEntry.find(params[:playlist_entry_id])).nil?
        entry.destroy      
      else
        flash[:notice] = "Cannot find any Playlist Entry!"
      end
      redirect_to :back
    else 
      redirect_to run_path, notice: 'You have to login to remove songs from a playlist!'
    end
 end

 # GET playlist_entry_id, next_playlist_entry_id
 
 def reorder
  if choosed_own_playlist
    
    playlist = PlaylistEntry.where(playlist_id: session[:playlist].id)

    entry = playlist.find(params[:playlist_entry_id])

    if !params[:next_playlist_entry_id].nil?
      next_entry = playlist.find(params[:next_playlist_entry_id])
      entry.append_to(next_entry.previous)      
    else
      entry.append_to(playlist.last_in_order)
    end
    render :nothing => true
  else
    redirect_to run_path, notice: 'You have to login to reorder songs in a playlist!'
  end
 end
end