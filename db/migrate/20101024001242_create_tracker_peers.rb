class CreateTrackerPeers < ActiveRecord::Migration
  def self.up
    create_table :tracker_peers do |t|
      t.string :name

      t.string :url
      t.string :callback_url

      t.string :admin_email

      t.string :consumer_key
      t.string :consumer_secret_key
      t.string :comsumer_request_token_url
      t.string :consumer_access_token_url
      t.string :consumer_authorize_url

      t.boolean :is_allowed

      t.timestamps
    end
  end

  def self.down
    drop_table :tracker_peers
  end
end
