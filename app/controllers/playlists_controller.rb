class PlaylistsController < ApplicationController
  before_filter :signed_in_user, :only => [:new, :edit, :update, :create, :destroy]
  before_filter :set_playlist, :only => [:show, :edit, :update, :destroy, :select]

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = 'The Playlist you tried to access does not exist'
    redirect_to run_path   
  end

  # GET /playlists
  # GET /playlists.json
  def index
    if (@playlists = Playlist.published).nil?
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
    @playlist_entries = @playlist.playlist_entries.page(params[:page])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @playlist }
    end
  end

  # GET /playlists/new
  # GET /playlists/new.json
  def new
    @playlist = Playlist.new(creator: current_user)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @playlist }
    end
  end

  # GET /playlists/1/edit
  def edit
  end

  # POST /playlists
  # POST /playlists.json
  def create
    @playlist = Playlist.create(params[:playlist])
    @playlist.creator = current_user

    respond_to do |format|
      if @playlist.save
        session[:playlist] = @playlist.id

        format.html { redirect_to @playlist, notice: 'Playlist was successfully created.' }
        format.json { render json: @playlist, status: :created, location: @playlist }
      else
        puts @playlist.to_yaml
        format.html { render action: "new" }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /playlists/1
  # PUT /playlists/1.json
  def update
    respond_to do |format|
      if @playlist.update_attributes(params[:playlist])
        format.html { redirect_to @playlist, notice: 'Playlist was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlists/1
  # DELETE /playlists/1.json
  def destroy
    @playlist.destroy

    respond_to do |format|
      format.html { redirect_to playlists_url }
      format.json { head :no_content }
    end
  end

  #GET /playlists/:id/select
  def select
      if !@playlist.published
        if !logged_in? or (logged_in? and @playlist.creator != current_user)
          flash[:notice] = "The creator of the choosen playlist, marked it as private."
          session[:playlist] = nil
        end        
      end

    session[:playlist] = @playlist.id
    redirect_to run_path 
  end

  private 
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end
end
