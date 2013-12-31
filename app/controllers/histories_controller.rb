class HistoriesController < ApplicationController

  # GET /users/history
  def show
    if logged_in
      @history_entries = current_user.history_entries.page(params[:page]).order("played_at DESC") 
    else 
      redirect_to current_user
    end 
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    if logged_in
      @history = History.find(params[:id])
      @history.destroy
    end 

    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end
end
