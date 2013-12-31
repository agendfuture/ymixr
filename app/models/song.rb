class Song < ActiveRecord::Base

  has_many :playlist_entries, :dependent => :destroy
  has_many :playlists, through: :playlist_entries

  has_many :histories, :dependent => :destroy
  has_many :users, through: :histories

  def self.findOrCreate(sid, title, artist=nil)
  		if !title.nil?
			@song = Song.find_or_create_by_sid(sid) do |t|
				t.title = title.strip
				if !artist.nil?
					t.artist = artist.strip
				end				
				t.play_count = 0
			end
			@song.play_count += 1
			@song.save
			@song
		else
			raise "No song title!" 
		end
	end
end
