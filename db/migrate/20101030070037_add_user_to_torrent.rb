class AddUserToTorrent < ActiveRecord::Migration
  def self.up
    add_column :torrents, :user_id, :integer
  end

  def self.down
    remove_column :torrents, :user_id
  end
end
