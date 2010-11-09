class IndexerPeersController < ApplicationController
  def new
    
  end

  def create
    @indexer_peer = IndexerPeer.new(params[:indexer_peer])
    @indexer_peer.save
  end


  # These are admin side only.
  def index
    @indexer_peers = IndexerPeer.all
  end

  def show
  
  end

  def destroy
    @indexer_peer = IndexerPeer.find(params[:id])
    @indexer_peer.destroy

    redirect_to :back
  end

  # This should be the point where the Indexer receives the request.
  def receive
      params[:name]
      params[:description]
      params[:info_hash]
      params[:torrent_file_url]

      torrent = Torrent.new(params)
      torrent.download_file_from_url(params[:torrent_file_url])
      
      torrent.send_to_indexer_peers
  end

end
