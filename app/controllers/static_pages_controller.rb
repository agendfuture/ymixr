class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def run
	   if !session[:playlist].nil?
        @playlist_entries_1 = PlaylistEntry.where(playlist_id: session[:playlist].id)
        @playlist_entries = PlaylistEntry.where(playlist_id: session[:playlist].id).ordered
      end

	   render template: "layouts/index"
  end
end
