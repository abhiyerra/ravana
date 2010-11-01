class TrackerPeerController < ApplicationController
  # Steps to verifying a tracker peer.
  # 1. Display a form which asks for tacker_infomation.
  # 2. Add that form to the database.
  # 3. Verify the tracker.
  #    a. Ask other trackers on our list for tracker credibility.
  #    b. Verify user manually.
  # 4. Once verified then send out new_torrents.
  def new
     
  end

  def create
    @tracker_peer = TrackerPeer.new(params[:tracker_peer])
    @tracker_peer.save
  end

  def manage

  end
end
