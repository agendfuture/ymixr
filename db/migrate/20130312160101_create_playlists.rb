class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.string :tilte
      t.text :description
      t.integer :tracking_id
      t.integer :user
      t.boolean :published

      t.timestamps
    end
    add_index :playlists, :tracking_id, :unique => true
  end
end
