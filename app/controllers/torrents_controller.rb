class TorrentsController < ApplicationController
  def index
    @torrents = Torrent.all
  end

  def show
    @torrent = Torrent.find(params[:id])
  end

  def new
  end

  def create
    @torrent = Torrent.create(params[:torrent])

    # TODO Modify the torrent and add local tracker
    @torrent.add_tracker

    # TODO Add a queue to send webhook response to TrackerPeers.

    redirect_to :action => 'show', :id => @torrent.id
  end

  def destroy
    # TODO Destroy the tracker on the local machine.
    # TODO Send request to remote peer

  end

  def latest
    @torrents = Torrent.limit(10)
  end

  def search
    @torrents = Torrent.search(params[:q])
  end
end
