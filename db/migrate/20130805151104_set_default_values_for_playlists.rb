class SetDefaultValuesForPlaylists < ActiveRecord::Migration
  def change
  	change_column :playlists, :published, :boolean, default: true
  	change_column :playlists, :description, :string, default: ""
  end
end
