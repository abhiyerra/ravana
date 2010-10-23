class TorrentsController < ApplicationController
  def index
    @torrents = Torrent.all
  end

  def show
    @torrent = Torrent.find(params[:id])
  end

  def new

  end

  def destroy

  end

  def file
    render :text => params[:id]
  end
end
