class AddJoinTables < ActiveRecord::Migration
  def change

  	remove_column :playlists, :pid
  	remove_column :songs, :sid

		create_table :playlist_entries, :id => false do |t|
        t.references :playlists
        t.references :songs
        t.integer :order
    end

		create_table :histories, :id => false do |t|
        t.references :users
        t.references :songs
        t.timestamp :played_at
    end

  end
end
