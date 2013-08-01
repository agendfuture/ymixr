class ChangeSongsSchema < ActiveRecord::Migration
  def change
  	change_table :songs do |t|
  		t.change :valid, :boolean, default:true
  		t.change :play_count, :integer, default:1
  		t.string :sid, default: "", :null=>false
  	end
  end
end
