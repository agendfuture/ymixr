# Migration to add the necessary fields to a resorted model
class AddResortFieldsToPlaylistEntries < ActiveRecord::Migration
  # Adds Resort fields, next_id and first, and indexes to a given model
  def self.up
    add_column :playlist_entries, :next_id, :integer
    add_column :playlist_entries, :first,   :boolean
    add_index :playlist_entries, :next_id
    add_index :playlist_entries, :first

    remove_column :playlist_entries, :next
    remove_column :playlist_entries, :previous
  end

  # Removes Resort fields
  def self.down
    remove_column :playlist_entries, :next_id
    remove_column :playlist_entries, :first

    add_column :playlist_entries, :next, :integer
    add_column :playlist_entries, :previous, :integer
  end
end

