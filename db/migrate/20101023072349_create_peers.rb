class CreatePeers < ActiveRecord::Migration
  def self.up
    create_table :peers do |t|
      t.integer :torrent_id

      t.string :peer_id
      t.integer :port

      t.float :uploaded
      t.float :downloaded

      t.float :left

      t.string :ip
      t.string :event

      t.timestamps
    end
  end

  def self.down
    drop_table :peers
  end
end
