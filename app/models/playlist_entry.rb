class PlaylistEntry < ActiveRecord::Base
  attr_accessible :id, :playlist_id, :song_id

  belongs_to :playlist
  belongs_to :song

  self.per_page = 10

  resort!
  
  def siblings
  	self.playlist.playlist_entries
  end
end
