class ChangeNameForPlaylistCreator < ActiveRecord::Migration
  def change
  	rename_column :playlists, :creator, :creator_id
  end
end
