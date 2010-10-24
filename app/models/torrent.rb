require 'bencode'

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

  def add_tracker
    torrent_file = self.torrent.to_file
    encoded_torrent = torrent_file.read
    decoded_torrent = encoded_torrent.bdecode

    if decoded_torrent['announce-list'].nil?
      decoded_torrent['announce-list'] = [TrackerAddress]
    else
      decoded_torrent['announce-list'] << TrackerAddress unless decoded_torrent['announce-list'].include?(TrackerAddress)
    end

    # TODO
#    torrent_file.write(decoded_torrent.bencode)
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
