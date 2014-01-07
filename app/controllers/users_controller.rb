class UsersController < ApplicationController
  before_filter :signed_in_user, :only => [:show]

  before_filter :set_user, :only => [:show, :playlists, :update, :edit]
  before_filter :set_playlists, :only => [:playlists, :show]

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = 'The User you tried to access does not exist'
    redirect_to run_path   
  end

  def show
    @history_entries = @user.history_entries.page(params[:page]).order("played_at DESC") 
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    if @user.save
      redirect_to new_sessions_path, :notice => "Welcome to youmixr!"
    else
      redirect_to new_user_path, :notice => "Sorry! An Error occured. Please repeat the previous steps."
    end
  end
 
  def update
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

  def edit
  end

  def playlists 
  end

  private 
    def set_user
      @user = User.find(params[:id])
    end

    def set_playlists
      @playlists = @user.playlists
    end
end