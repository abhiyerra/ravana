class TorrentsController < ApplicationController
  def show
    @torrent = Torrent.find(params[:id])
    @comments = []
  end

  def new
  end

  def create
    torrent = Torrent.create(params[:torrent])

    # TODO
    if params[:tracker_key]
      # We want to handle it a bit differently if it
      # comes from a tracker peer.
      indexer_peer = IndexerPeer.where(:tracker_key => params[:tracker_key])
      torrent.indexer_peer = indexer_peer
    else
      torrent.user = current_user
    end

    torrent.save    

    redirect_to :action => 'show', :id => torrent
  end

  def destroy
    # TODO Destroy the tracker on the local machine.
    # TODO Send request to remote peer
  end

  def search
    @torrents = Torrent.search(params[:q])
  end
end
