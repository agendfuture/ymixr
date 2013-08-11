class HistoriesController < ApplicationController

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
