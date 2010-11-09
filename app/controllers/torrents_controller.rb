class TorrentsController < ApplicationController
  def show
    @torrent = Torrent.find(params[:id])
    @comments = []
  end

  def new
  end

  def create
    # TODO
    if params[:tracker_peer]
      # We want to handle it a bit differently if it
      # comes from a tracker peer.
      @torrent = Torrent.create(params[:torrent])
    else
      @torrent = Torrent.create(params[:torrent])
    end
    
    @torrent.add_tracker
    IndexerPeer.send_new_torrent(@torrent)
 
    redirect_to :action => 'show', :id => @torrent
  end

  def destroy
    # TODO Destroy the tracker on the local machine.
    # TODO Send request to remote peer
  end

  def search
    @torrents = Torrent.search(params[:q])
  end
end
