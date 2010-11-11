class IndexerPeersController < ApplicationController
  def new
  end

  def create
    indexer_peer = IndexerPeer.new(params[:indexer_peer])
    indexer_peer.user = current_user
    indexer_peer.save

    flash[:notice] = "Your request is being reviewed. More information may be requested so please keep an eye out for an email."
    redirect_to :action => :index
  end

  # These are admin side only.
  def index
    @indexer_peers = IndexerPeer.all
  end

  def show
    @indexer_peer = IndexerPeer.find(params[:id])
  end

  def destroy
    @indexer_peer = IndexerPeer.find(params[:id])
    @indexer_peer.destroy

    redirect_to :back
  end

  def trusted
      @indexer_peer = IndexerPeer.find(params[:id])
      @indexer_peer.is_trusted = params[:is_trusted].downcase.eql?('yes')
      @indexer_peer.save

      redirect_to :back
  end
end
