class PlaylistEntry < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :song

  validates :playlist_id, presence: true
  validates :song_id, presence: true   

  self.per_page = 10

  acts_as_list scope: :playlist

  def self.transform_position
    playlist = Playlist.all

    playlist.each do |pl|
      pp pl
      last = pl.playlist_entries.where(position: nil).first
      pl.playlist_entries.each_with_index do |pe, index|
        pe.update(position: index + 1)
      end
      last.move_to_bottom if !last.nil?
    end
  end
end
