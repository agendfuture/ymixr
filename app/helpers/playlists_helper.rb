module PlaylistsHelper
  def choosed_playlist
    return (logged_in? and !session[:playlist].nil?)
  end

  def choosed_own_playlist
    return (choosed_playlist and Playlist.where(id: session[:playlist], creator: current_user).exists?)
  end
end
