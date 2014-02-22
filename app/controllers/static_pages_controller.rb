class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def run
    unless session[:playlist].nil?
      @playlist = Playlist.find(session[:playlist])
    end

	   render template: "layouts/index"
  end
end
