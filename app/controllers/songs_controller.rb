class SongsController < ApplicationController
  # GET /songs
  # GET /songs.json
  def index
    if params[:source_filter].nil?
      @songs = Song.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @songs }
      end      
    end
  end

  # GET /songs/1
  # GET /songs/1.json
  def show
    plattform = params[:id].split(':')
    if plattform[0] == "yt"     
      @yt_video = YM_Youtube.client.video_by(plattform[1])
    end

    respond_to do |format|
      format.html
      format.js
    end

    #@song = Song.find(params[:id])

    #respond_to do |format|
    #  format.html # show.html.erb
    #  format.json { render json: @song }
    #end
  end

  # GET /songs/new
  # GET /songs/new.json
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.find(params[:id])
  end

  # POST /songs
  # POST /songs.json
  def create
    @song = Song.new(params[:song])

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: 'Song was successfully created.' }
        format.json { render json: @song, status: :created, location: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  # PUT /songs/1.json
  def update
    @song = Song.find(params[:id])

    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to @song, notice: 'Song was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  # DELETE /songs/1.json
  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    respond_to do |format|
      format.html { redirect_to songs_url }
      format.json { head :no_content }
    end
  end

  def play
    plattform = params[:id].split(':')
    if plattform == "yt"
      @song = YM_Plattform.create(params[:id])
      respond_to do |format|
        format.js {render :template => @song.get_player }
        format.html { render :template => @song.get_player }
      end
    else
      respond_to do |format|
        format.js {render :nothing => true }
        format.html {render :nothing => true }
      end
    end

  end
  
  def search
    # Youtube Controller
    if !params[:source_filter].nil?
      if params[:source_filter].include?("yt")
        
        @yt_videos = YM_Youtube.client.videos_by(:query => params[:song_search]).videos
        @search_route = "_youtube_search_results"

      elsif params[:source_filter].include?("vi")
  	
      end
    end

    if @search_route.nil?
      render :nothing => true
    else
      respond_to do |format|
        format.html {render @search_route, :layout => false}
        format.js
      end
    end
  end

  def soundcloudTemplate
    respond_to do |format|
      format.html {render "_soundcloud_search_results", :layout => false}
      format.js 
    end
  end

end
