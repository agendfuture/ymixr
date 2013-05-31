class Videos < ActiveRecord::Base
  attr_accessible :created_at, :description, :is_complete, :title, :updated_at, :yt_video_id
end
