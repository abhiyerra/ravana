class TrackerController < ApplicationController
  NumWant = 50
  MinTrackerInterval = 3000
  TrackerInterval = 300

  def announce
    # Find the torrent and the peer.
    @torrent = Torrent.where(:info_hash => params[:info_hash]).first
    @peer = Peer.where(:peer_id => params[:peer_id], :torrent_id => @torrent.id).first

    # Check if the event is started in which case create a new peer.
    if @peer.nil? || params[:event].eql?('started')
      @peer = Peer.create(:peer_id => params[:peer_id], :torrent_id => @torrent.id)
    end

    updated_peer_attributes = {
      :uploaded   => params[:uploaded].to_i,
      :downloaded => params[:downloaded].to_i,
      :left       => params[:left].to_i,
      :event      => params[:event],
      :port       => params[:port].to_i,
      :ip         => params[:ip] ? params[:ip] : request.remote_ip
    }

    @peer.update_attributes updated_peer_attributes

    @numwant = params[:numwant] ? params[:numwant].to_i : NumWant

    @peers = Peer.where(["torrent_id = ? and event != 'stopped'", @torrent.id])
    if @peers.empty?
      return render :text => { "failure reason" => "No peers" }.bencode
    end

    num_completed_peers = Peer.where(["torrent_id = ? and event = 'completed'", @torrent.id]).count

    render :text => {
      #"warning message" => "",
      "interval" => TrackerInterval,
      "min interval" => MinTrackerInterval,
      "tracker id" => @peer.peer_id,
      "complete" => num_completed_peers,
      "incomplete" => @peers.count,
      "peers" => @peers.map do |peer|
        {
          "peer id" => peer.id,
          "ip" => peer.ip,
          "port" => peer.port
        }
      end
    }.bencode
  end

# The tracker responds with "text/plain" document consisting of a bencoded dictionary with the following keys:



#     * tracker id: A string that the client should send back on its next announcements. If absent and a previous announce sent a tracker id, do not discard the old value; keep using it.




#compact: Setting this to 1 indicates that the client accepts a compact response. The peers list is replaced by a peers string with 6 bytes per peer. The first four bytes are the host (in network byte order), the last two bytes are the port (again in network byte order). It should be noted that some trackers only support compact responses (for saving bandwidth) and either refuse requests without "compact=1" or simply send a compact response unless the request contains "compact=0" (in which case they will refuse the request.)
#no_peer_id: Indicates that the tracker can omit peer id field in peers dictionary. This option is ignored if compact is enabled.

#key: Optional. An additional identification that is not shared with any users. It is intended to allow a client to prove their identity should their IP address change.
#trackerid: Optional. If a previous announce contained a tracker id, it should be set here.

  def new
    
  end
end
