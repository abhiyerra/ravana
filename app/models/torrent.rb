require 'bencode'

class Torrent < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :peers

  has_attached_file :torrent

  before_save :add_tracker
  after_save :send_to_indexer_peers

  def total_downloaded
    self.peers.map(&:downloaded).sum
  end

  def total_uploaded
    self.peers.map(&:uploaded).sum
  end

  def download_file_from_url

  end

  def torrent_file_decoded
    torrent_file = torrent.to_file.read
    torrent_file.bdecode
  end

  def trackers
    torrent_file = torrent.to_file.read
    torrent_file.bdecode['announce-list']
  end

  def add_tracker
    torrent_file = torrent.to_file

    encoded = torrent_file.read
    decoded = encoded.bdecode

    if decoded['announce-list'].nil?
      decoded['announce-list'] = [TrackerAddress]
    else
      decoded['announce-list'] << TrackerAddress
    end
    decoded['announce-list'] = decoded['announce-list'].uniq

    torrent_file.write(decoded.bencode)
  end
  def send_to_indexer_peers
    # Only send to verified trackers.
    IndexerPeer.where(:is_allowed => true).each do |tracker_peer|
      tracker_peer.send_new_torrent self
    end
  end

  # TODO: Make this do a search based on MySQL/PostgreSQL/Sqlite
  def self.search query
    self.all
  end

  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"
  end
end
