class CreatePeers < ActiveRecord::Migration
  def self.up
    create_table :peers do |t|
      t.integer :torrent_id

      t.string :peer_id

      t.string :ip
      t.integer :port

      t.integer :uploaded
      t.integer :downloaded

      t.integer :left

      t.string :event

      t.timestamps
    end
  end

  def self.down
    drop_table :peers
  end
end
