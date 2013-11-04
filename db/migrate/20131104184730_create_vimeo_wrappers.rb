class CreateVimeoWrappers < ActiveRecord::Migration
  def change
    create_table :vimeo_wrappers do |t|

      t.timestamps
    end
  end
end
