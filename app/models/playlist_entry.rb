class PlaylistEntry < ActiveRecord::Base
  attr_accessible :order, :playlist_id, :song_id

  belongs_to :playlist
  belongs_to :song
end
