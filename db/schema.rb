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

ActiveRecord::Schema.define(:version => 20101120210233) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_applications", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "support_url"
    t.string   "callback_url"
    t.string   "key",          :limit => 40
    t.string   "secret",       :limit => 40
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_applications", ["key"], :name => "index_client_applications_on_key", :unique => true

  create_table "indexer_peers", :force => true do |t|
    t.integer  "user_id"
    t.string   "url"
    t.string   "callback_url"
    t.string   "consumer_key"
    t.string   "consumer_secret_key"
    t.string   "comsumer_request_token_url"
    t.string   "consumer_access_token_url"
    t.string   "consumer_authorize_url"
    t.text     "public_key"
    t.string   "fingerprint"
    t.boolean  "is_trusted"
    t.integer  "indexer_peer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_nonces", :force => true do |t|
    t.string   "nonce"
    t.integer  "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_nonces", ["nonce", "timestamp"], :name => "index_oauth_nonces_on_nonce_and_timestamp", :unique => true

  create_table "oauth_tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "type",                  :limit => 20
    t.integer  "client_application_id"
    t.string   "token",                 :limit => 40
    t.string   "secret",                :limit => 40
    t.string   "callback_url"
    t.string   "verifier",              :limit => 20
    t.string   "scope"
    t.datetime "authorized_at"
    t.datetime "invalidated_at"
    t.datetime "valid_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "oauth_tokens", ["token"], :name => "index_oauth_tokens_on_token", :unique => true

  create_table "peers", :force => true do |t|
    t.integer  "torrent_id"
    t.string   "peer_id"
    t.string   "ip"
    t.integer  "port"
    t.integer  "uploaded"
    t.integer  "downloaded"
    t.integer  "left"
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
    t.integer  "alternate_to_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.integer  "user_id"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "ref_code",                                               :null => false
    t.boolean  "is_admin",                            :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true
  add_index "users", ["ref_code"], :name => "index_users_on_ref_code", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
