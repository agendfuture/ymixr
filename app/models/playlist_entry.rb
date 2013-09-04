class PlaylistEntry < ActiveRecord::Base
  attr_accessible :id, :playlist_id, :song_id

  belongs_to :playlist
  belongs_to :song

  resort!
  
  def siblings
  	self.playlist.playlist_entries
  end
end
