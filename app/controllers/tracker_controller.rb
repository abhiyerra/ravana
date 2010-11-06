
class TrackerController < ApplicationController
  NumWant = 50

  def announce
    # Find the torrent and the peer.
    @torrent = Torrent.where(:info_hash => params[:info_hash]).first
    @peer = Peer.where(:peer_id => params[:peer_id], :torrent_id => @torrent.id).first

    # Check if the event is started in which case create a new peer.
    if @peer.nil? || params[:event].eql?('started')
      @peer = Peer.create(:peer_id => params[:peer_id], :torrent_id => @torrent.id)
    end

    ip = params[:ip] if params[:ip]

    updated_peer_attributes = {
      :uploaded   => params[:uploaded].to_i,
      :downloaded => params[:downloaded].to_i,
      :left       => params[:left].to_i,
      :event      => params[:event],
      :port       => params[:port].to_i,
      :ip         => params[:ip]
    }

    @peer.update_attributes updated_peer_attributes

    @numwant = params[:numwant] ? params[:numwant].to_i : NumWant

    @peers = Peer.where(["torrent_id = ? and event = '' or event = 'started'", @torrent.id])

    render :text => 'hello google'
  end



#compact: Setting this to 1 indicates that the client accepts a compact response. The peers list is replaced by a peers string with 6 bytes per peer. The first four bytes are the host (in network byte order), the last two bytes are the port (again in network byte order). It should be noted that some trackers only support compact responses (for saving bandwidth) and either refuse requests without "compact=1" or simply send a compact response unless the request contains "compact=0" (in which case they will refuse the request.)
#no_peer_id: Indicates that the tracker can omit peer id field in peers dictionary. This option is ignored if compact is enabled.
    #

#event: If specified, must be one of started, completed, stopped, (or empty which is the same as not being specified). If not specified, then this request is one performed at regular intervals.
  #started: The first request to the tracker must include the event key with this value.
  #stopped: Must be sent to the tracker if the client is shutting down gracefully.
  #completed: Must be sent to the tracker when the download completes. However, must not be sent if the download was already 100% complete when the client started. Presumably, this is to allow the tracker to increment the "completed downloads" metric based solely on this event.


    #
#ip: Optional. The true IP address of the client machine, in dotted quad format or rfc3513 defined hexed IPv6 address. Notes: In general this parameter is not necessary as the address of the client can be determined from the IP address from which the HTTP request came. The parameter is only needed in the case where the IP address that the request came in on is not the IP address of the client. This happens if the client is communicating to the tracker through a proxy (or a transparent web proxy/cache.) It also is necessary when both the client and the tracker are on the same local side of a NAT gateway. The reason for this is that otherwise the tracker would give out the internal (RFC1918) address of the client, which is not routable. Therefore the client must explicitly state its (external, routable) IP address to be given out to external peers. Various trackers treat this parameter differently. Some only honor it only if the IP address that the request came in on is in RFC1918 space. Others honor it unconditionally, while others ignore it completely. In case of IPv6 address (e.g.: 2001:db8:1:2::100) it indicates only that client can communicate via IPv6.
#key: Optional. An additional identification that is not shared with any users. It is intended to allow a client to prove their identity should their IP address change.
#trackerid: Optional. If a previous announce contained a tracker id, it should be set here.
#  #
  #

  def new
    
  end
end
