class Song < ActiveRecord::Base
  attr_accessible :title, :url, :artist, :sid

  has_many :playlist_entries, :dependent => :destroy
  has_many :playlists, through: :playlist_entries

  has_many :histories, :dependent => :destroy
  has_many :users, through: :histories

  def self.findOrCreate(sid, title=nil, artist=nil)
		@song = Song.find_or_create_by_sid(sid) do |t|
			t.title = title
			t.artist = artist
			t.play_count = 0
		end
		@song.play_count += 1
		@song.save
		@song
	end
end
