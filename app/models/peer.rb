class Peer < ActiveRecord::Base
  belongs_to :torrent

  def self.delete_stales
    Peer.where(["updated_at > ?", 5.days.ago).each do |p|
      p.destroy
    end
  end
end
