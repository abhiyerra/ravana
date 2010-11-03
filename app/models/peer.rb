class Peer < ActiveRecord::Base
  belongs_to :torrent

  StaleAfter = 5.days.ago

  def self.delete_stales
    Peer.where(["updated_at > ?", StaleAfter).each do |p|
      p.destroy
    end
  end
end
