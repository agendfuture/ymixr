class CreatePlaylistEntries < ActiveRecord::Migration
  def change
    create_table :playlist_entries do |t|
      t.integer :song_id
      t.integer :playlist_id
      t.integer :order

      t.timestamps
    end
  end
end
