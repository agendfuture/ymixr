class HistoriesController < ApplicationController
  before_filter :signed_in_user

  # GET /users/history
  def index
    @history_entries = current_user.history_entries.page(params[:page]).order("played_at DESC") 
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history = History.find(params[:id])
    @history.destroy
    
    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end
end
