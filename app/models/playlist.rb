class Playlist < ActiveRecord::Base
  attr_accessible :description, :published, :title, :creator

  belongs_to :user, foreign_key: :creator

  has_many :playlist_entries, dependent: :destroy
  has_many :songs, through: :playlist_entries

  self.per_page = 5

end
