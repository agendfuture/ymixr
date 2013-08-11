class History < ActiveRecord::Base
  attr_accessible :played_at, :user_id, :song_id

  belongs_to :user
  belongs_to :song
end
