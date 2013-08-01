# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130801191207) do

  create_table "histories", :id => false, :force => true do |t|
    t.integer  "users_id"
    t.integer  "songs_id"
    t.datetime "played_at"
  end

  create_table "playlist_entries", :id => false, :force => true do |t|
    t.integer "playlists_id"
    t.integer "songs_id"
    t.integer "order"
  end

  create_table "playlists", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "creator"
    t.boolean  "published"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "play_count"
  end

  create_table "songs", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at",                   :null => false
    t.string   "album"
    t.string   "artist"
    t.boolean  "valid",      :default => true
    t.integer  "play_count", :default => 1
    t.string   "sid",        :default => "",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "yt_video_id"
    t.boolean  "is_complete"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
