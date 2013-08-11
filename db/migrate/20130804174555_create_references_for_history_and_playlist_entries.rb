class CreateReferencesForHistoryAndPlaylistEntries < ActiveRecord::Migration
  def change
  	change_table :histories do |t|
      t.belongs_to :user
      t.belongs_to :song
    end
  end
end
