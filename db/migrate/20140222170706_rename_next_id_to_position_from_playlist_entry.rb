class RenameNextIdToPositionFromPlaylistEntry < ActiveRecord::Migration
  def change
  	rename_column :playlist_entries, :next_id, :position
  	remove_column :playlist_entries, :first
  end
end
