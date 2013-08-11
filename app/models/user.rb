class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  attr_accessible :email, :name, :password, :password_confirmation

  has_many :playlists, dependent: :destroy
  has_many :histories, dependent: :destroy
  has_many :songs, through: :histories
end
