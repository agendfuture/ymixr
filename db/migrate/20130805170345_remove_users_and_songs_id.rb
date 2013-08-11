class RemoveUsersAndSongsId < ActiveRecord::Migration
  def change
  	remove_column :histories, :users_id
  	remove_column :histories, :songs_id
  end
end
