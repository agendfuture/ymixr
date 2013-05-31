class StaticPagesController < ApplicationController
  def home
  end

  def help
  end

  def run
	yt_client
	@videos = @yt_client.videos_by(:most_viewed).videos
  end

end
