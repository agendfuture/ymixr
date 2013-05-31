class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :description
      t.string :yt_video_id
      t.boolean :is_complete
      t.timestamp :created_at
      t.timestamp :updated_at

      t.timestamps
    end
  end
end
