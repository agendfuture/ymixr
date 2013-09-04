class AddDoubleLinkedListToPlaylistEntries < ActiveRecord::Migration
  def change
  	change_table :playlist_entries do |t|
  		t.rename :order, :next
  		t.integer :previous
  	end
  end
end
