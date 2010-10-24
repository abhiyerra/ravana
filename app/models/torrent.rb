class Torrent < ActiveRecord::Base
  belongs_to :categories
  has_many :peers

  has_attached_file :torrent

  after_save :send_to_tracker_peers

  # TODO: Before destroy should delete the peers.
  def total_downloaded
    0.0
  end

  def total_leeched
    0.0
  end

  def add_tracker_to_torrent

  end

  def send_to_tracker_peers
    # Only send to verified trackers.
    TrackerPeer.where(:is_allowed => true).each do |tracker_peer|
      tracker_peer.send_new_torrent
    end
  end

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
