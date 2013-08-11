class RenameValidToActiveInSongs < ActiveRecord::Migration
  def up
	rename_column :songs, :valid, :active
  end

  def down
	rename_column :songs, :active, :valid
  end
end
