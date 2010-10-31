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

ActiveRecord::Schema.define(:version => 20101030070037) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "peers", :force => true do |t|
    t.integer  "torrent_id"
    t.string   "peer_id"
    t.integer  "port"
    t.float    "uploaded"
    t.float    "downloaded"
    t.float    "left"
    t.string   "ip"
    t.string   "event"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "torrents", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "info_hash"
    t.string   "torrent_file_name"
    t.string   "torrent_content_type"
    t.integer  "torrent_file_size"
    t.datetime "torrent_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "user_id"
  end

  create_table "tracker_peers", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "callback_url"
    t.string   "admin_email"
    t.string   "consumer_key"
    t.string   "consumer_secret_key"
    t.string   "comsumer_request_token_url"
    t.string   "consumer_access_token_url"
    t.string   "consumer_authorize_url"
    t.boolean  "is_allowed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
