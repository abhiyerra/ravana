module TorrentsHelper
  def trackers_for torrent
    raw torrent.trackers.sort.join("<br>")
  end
end
