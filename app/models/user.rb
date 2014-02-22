class User < ActiveRecord::Base
  has_secure_password
  validate :password, :on => :create, presence: :true
  validate :name, :email, uniquene: :true

  has_many :playlists, foreign_key: :creator_id, dependent: :destroy

  has_many :history_entries, :class_name => "History", :include => :song, dependent: :destroy
  has_many :played_songs, through: :histories, :source => :song
end
