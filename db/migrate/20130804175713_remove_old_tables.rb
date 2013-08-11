class RemoveOldTables < ActiveRecord::Migration
  def change
  	drop_table :videos
  	drop_table :playlist_entries
  end
end
