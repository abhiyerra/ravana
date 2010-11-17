class IndexerPeer < ActiveRecord::Base
  
  validates_uniqueness_of :url
  validates_uniqueness_of :callback_url

  belongs_to :user

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

  def public_key_stats

  end

  def signatures
    gpgme = GPGME::Ctx.new 
    
    # TODO Look at actual fingerprint
    fpr = "F3702CBB2E0E319F3BC77D8A67280F23EC92C369"
    
    pair = []
    gpgme.get_key(fpr).uids.each do |uid|
      pair << "#{uid.name} #{uid.email}"
    end
    pair
  end

  def self.send_new_torrent(torrent)
      self.all.each do |tracker_peer|
          torrent_info = {
              'tracker_key'      => torrent.id, # TODO: Change to local key.
          }
          
          torrent_info[:torrent] = {
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
