class Torrent < ActiveRecord::Base
  belongs_to :categories
  has_many :peers

  has_attached_file :torrent

  # TODO: Before destroy should delete the peers.
  def total_downloaded
    0.0
  end

  def total_leeched
    0.0
  end
end
