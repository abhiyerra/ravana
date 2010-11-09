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
end
