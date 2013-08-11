class AddIndexToHistory < ActiveRecord::Migration
  def change
  	add_column :histories, :id, :primary_key 
  end
end
