module PlaylistsHelper
	def choosed_playlist
    return (logged_in? and !session[:playlist].nil?)
  end

  def choosed_own_playlist
    return (choosed_playlist and session[:playlist].creator == current_user)    
  end
end
