class UpdateDatabaseSchemaForHistory < ActiveRecord::Migration
  def change

  	change_table :songs do |t|
		  t.remove :updated_at
		  t.string :album, :artist
		  t.boolean :valid
		  t.integer :play_count
		  t.rename :id, :sid
		  
		end

		change_table :playlists do |t|
			t.rename :id, :pid
			t.rename :tilte, :title
			t.rename :user, :creator
			t.integer :play_count
			t.remove :tracking_id
		end
  end
end
