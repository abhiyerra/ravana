class CreateTorrents < ActiveRecord::Migration
  def self.up
    create_table :torrents do |t|
      t.string :name
      t.text :description

      t.string :info_hash

      t.string :torrent_file_name
      t.string :torrent_content_type
      t.integer :torrent_file_size
      t.datetime :torrent_updated_at

      t.timestamps
    end
  end

  def self.down
    drop_table :torrents
  end
end
