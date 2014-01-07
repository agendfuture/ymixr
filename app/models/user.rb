class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_uniqueness_of :name, :email
  attr_accessible :email, :name, :password, :password_confirmation

  has_many :playlists, foreign_key: :creator_id, dependent: :destroy

  has_many :history_entries, :class_name => "History", :include => :song, dependent: :destroy
  has_many :played_songs, through: :histories, :source => :song
end
