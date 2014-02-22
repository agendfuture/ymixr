class Playlist < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  has_many :playlist_entries, -> { order("position ASC") }, dependent: :destroy
  has_many :songs, through: :playlist_entries

  validates :title, presence: :true
  validates :creator, presence: :true

  self.per_page = 5

  scope :published, -> { where(published: :t) }

end
