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

ActiveRecord::Schema.define(:version => 20130904164450) do

  create_table "histories", :force => true do |t|
    t.datetime "played_at"
    t.integer  "user_id"
    t.integer  "song_id"
  end

  create_table "playlist_entries", :force => true do |t|
    t.integer  "song_id"
    t.integer  "playlist_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "next_id"
    t.boolean  "first"
  end

  add_index "playlist_entries", ["first"], :name => "index_playlist_entries_on_first"
  add_index "playlist_entries", ["next_id"], :name => "index_playlist_entries_on_next_id"

  create_table "playlists", :force => true do |t|
    t.string   "title"
    t.string   "description", :default => ""
    t.integer  "creator"
    t.boolean  "published",   :default => true
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "play_count"
  end

  create_table "songs", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at",                   :null => false
    t.string   "album"
    t.string   "artist"
    t.boolean  "active",     :default => true
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

end
