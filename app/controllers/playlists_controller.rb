class PlaylistsController < ApplicationController
  # GET /playlists
  # GET /playlists.json
  def index
    if (@playlists = Playlist.where(published: :t)).nil?
      respond_to do |format|
        format.html {redirect_to run_path }
      end
    else
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @playlists }
      end
    end
  end

  # GET /playlists/1
  # GET /playlists/1.json
  def show
    @playlist = Playlist.find(params[:id])

    @username = User.find(@playlist.creator).name

    @songs = Song.joins(:playlist_entries).where(playlist_entries: {playlist_id: @playlist.id})

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @playlist }
    end
  end

  # GET /playlists/new
  # GET /playlists/new.json
  def new
    if logged_in
      @playlist = Playlist.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @playlist }
      end
    else 
      respond_to do |format|
        format.html {redirect_to run_path, notice: 'You have to login to create playlists!'}
      end
    end
  end

  # GET /playlists/1/edit
  def edit
    if logged_in
      @playlist = Playlist.find(params[:id])
    else 
      respond_to do |format|
        format.html {redirect_to run_path, notice: 'You have to login to create playlists!'}
      end
    end
  end

  # POST /playlists
  # POST /playlists.json
  def create
    if logged_in
      @playlist = Playlist.new(:title => params[:title], :creator => current_user.id)

      respond_to do |format|
        if @playlist.save
          session[:playlist] = @playlist

          format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
          format.json { render json: @playlist, status: :created, location: @playlist }
        else
          format.html { render action: "new" }
          format.json { render json: @playlist.errors, status: :unprocessable_entity }
        end
      end
    else 
      respond_to do |format|
        format.html {redirect_to run_path, notice: 'You have to login to create playlists!'}
      end
    end
  end

  # PUT /playlists/1
  # PUT /playlists/1.json
  def update
    if logged_in
      @playlist = Playlist.find(params[:id])

      respond_to do |format|
        if @playlist.update_attributes(params[:playlist])
          format.html { redirect_to @playlist, notice: 'Playlist was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @playlist.errors, status: :unprocessable_entity }
        end
      end
    else 
      respond_to do |format|
        format.html {redirect_to run_path, notice: 'You have to login to create playlists!'}
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    if logged_in
      @playlist = Playlist.find(params[:id])
      @playlist.destroy

      respond_to do |format|
        format.html { redirect_to playlists_url }
        format.json { head :no_content }
      end
    else 
      respond_to do |format|
        format.html {redirect_to run_path, notice: 'You have to login to create playlists!'}
      end
    end
  end

  #GET /playlists/:id/select
  def select
    if logged_in
      session[:playlist] = Playlist.where(id: params[:id], creator: current_user.id).first      
      redirect_to run_path  
    else
      redirect_to run_path, notice: "You have to login, if you wan't to listen to a playlist!"
    end
  end

  # GET /playlists/:id/add/:sid
  def add
    if logged_in      
      if !session[:playlist].nil?
        params[:id] = (params[:id] == session[:playlist].id)? params[:id] : session[:playlist].id

        @song = Song.findOrCreate(params[:sid])
        
        @playlist_entry = PlaylistEntry.create(song_id: @song.id, playlist_id: params[:id])
        if !@playlist_entry.save
          flash[:notice] = "Error while creating a playlist entry for the current song."
        end
      end
      
      respond_to do |format|
        format.html {render :nothing => true}
        format.js {render :nothing => true}
      end      
    else 
      redirect_to run_path, notice: 'You have to login to create or change playlists!'      
    end
  end

  def remove
    if logged_in
      render :nothing => true
    else 
      redirect_to run_path, notice: 'You have to login to create playlists!'
    end
  end
end
