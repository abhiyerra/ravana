class TrackerPeer < ActiveRecord::Base
  
  validates_uniqueness_of :name
  validates_uniqueness_of :url
  validates_uniqueness_of :callback_url
 
  def verify_tracker_peer
      # t.string :name

      # t.string :url
      # t.string :callback_url

      # t.string :admin_email

      # t.string :consumer_key
      # t.string :consumer_secret_key
      # t.string :comsumer_request_token_url
      # t.string :consumer_access_token_url
      # t.string :consumer_authorize_url

      # t.boolean :is_allowed

  end

  def self.send_new_torrent(torrent)
      TrackerPeer.all.each do |tracker_peer|
          torrent_info = {
              'name'             => torrent.name,
              'description'      => torrent.description,
              'info_hash'        => torrent.info_hash,
              'torrent_file_url' => torrent.torrent.url
          }

          # TODO Do this using oauth.
          RestRequest.post(tracker_peer.callback_url, torrent_info)
      end
  end
end
