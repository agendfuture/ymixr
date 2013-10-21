class PlaylistEntriesController < ApplicationController
  before_filter :authorize

  def authorize
    if !choosed_own_playlist
      redirect_to run_path, notice: 'You have to login to create or change playlists!'      
    end
  end

  # POST /playlists/:playlist_id/playlist_entries/:playlist_entry_id/add      Deprecated !!
  # POST /playlists/:playlist_id/playlist_entries/:playlist_entry_id/add.js

  # POST /playlists/:playlist_id/playlist_entries
  # POST /playlists/:playlist_id/playlist_entries.js

  # GET  /playlists/addSong/:sid
  # GET  /playlists/addSong/:sid.js
 def create    
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
 end

 # DELETE /playlists/:playlist_id/playlist_entries/:id
 # DELETE /playlists/:playlist_id/playlist_entries/:playlist_entry_id/remove Deprecated!!!
 # GET    /playlists/removeSong/:playlist_entry_id
 def destroy
  if !(entry = PlaylistEntry.find(params[:playlist_entry_id])).nil?
    entry.destroy      
  else
    flash[:notice] = "Cannot find any Playlist Entry!"
  end
  redirect_to :back
 end

 # GET /playlists/reorder/:playlist_entry_id/:next_playlist_entry_id
 # GET /playlists/reorder/:playlist_entry_id
 def reorder
  playlist = PlaylistEntry.where(playlist_id: session[:playlist].id)
  entry = playlist.find(params[:playlist_entry_id])

  if !params[:next_playlist_entry_id].nil?
    next_entry = playlist.find(params[:next_playlist_entry_id])
    if !next_entry.previous.nil?
      entry.append_to(next_entry.previous) 
    else
      entry.prepend
    end     
  else
    entry.append_to(playlist.last_in_order)
  end
  render :nothing => true
 end
end