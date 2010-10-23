class CreateTorrents < ActiveRecord::Migration
  def self.up
    create_table :torrents do |t|
      t.string :name
      t.string :filename

      t.text :description

      t.string :info_hash

      t.timestamps
    end
  end

  def self.down
    drop_table :torrents
  end
end
