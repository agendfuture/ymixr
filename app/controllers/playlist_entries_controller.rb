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
  params[:id] = (params[:id] == session[:playlist])? params[:id] : session[:playlist]

  playlist = Playlist.find(params[:id])
  song = Song.findOrCreate(params[:sid], params[:title], params[:artist])

  playlist.songs << song 

  entry = playlist.playlist_entries.where(song_id: song.id).take
  entry.move_to_bottom

  respond_to do |format|
    format.html {render :text => "{\"id\" : #{entry.id}}"}
    format.js 
  end      
 end

 # DELETE /playlists/:playlist_id/playlist_entries/:id
 # DELETE /playlists/:playlist_id/playlist_entries/:playlist_entry_id/remove Deprecated!!!
 # GET    /playlists/removeSong/:playlist_entry_id
 def destroy
  unless (entry = PlaylistEntry.find(params[:playlist_entry_id])).nil?
    entry.destroy      
  else
    flash[:notice] = "Cannot find any Playlist Entry!"
  end
  redirect_to :back
 end

 # GET /playlists/reorder/:playlist_entry_id/:next_playlist_entry_id
 # GET /playlists/reorder/:playlist_entry_id
 def reorder
  entry = PlaylistEntry.where(id: params[:playlist_entry_id], playlist_id: session[:playlist]).take
  if entry.nil?
    render nothing: true
  end

  next_entry = PlaylistEntry.where(id: params[:next_playlist_entry_id], playlist_id: session[:playlist]).take

  unless next_entry.nil?
    entry.insert_at(next_entry.position) 
  else
    entry.move_to_bottom
  end

  render nothing: true
 end
end