class AddPublicKeyToTrackerPeer < ActiveRecord::Migration
  def self.up
    add_column :tracker_peers, :public_key, :text
  end

  def self.down
    remove_column :tracker_peers, :public_key
  end
end
