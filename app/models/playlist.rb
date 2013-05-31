class Playlist < ActiveRecord::Base
  attr_accessible :description, :published, :tilte, :tracking_id, :user
end
