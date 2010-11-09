class CreateIndexerPeers < ActiveRecord::Migration
  def self.up
    create_table :indexer_peers do |t|
      t.integer :user_id

      t.string :url
      t.string :callback_url

      t.string :consumer_key
      t.string :consumer_secret_key
      t.string :comsumer_request_token_url
      t.string :consumer_access_token_url
      t.string :consumer_authorize_url

      t.text :public_key

      t.boolean :is_trusted

      t.timestamps
    end
  end

  def self.down
    drop_table :indexer_peers
  end
end
